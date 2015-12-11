//
//  NotaDao.swift
//  MyNotes
//
//  Created by Aplimovil on 12/10/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import Foundation
import SQLite

class NoteDao{

    
    var db:Connection!
    let table = Table("nota")
    let id = Expression<Int64>("id")
    let tittle = Expression<String>("titulo")
    let descripcion = Expression<String>("descripcion")
    let date = Expression<String>("fecha")
    
    init(){
        do{
            let path = NSSearchPathForDirectoriesInDomains(
                .DocumentDirectory, .UserDomainMask, true
                ).first!
            
            db = try Connection("\(path)/nota.sqlite3")
            try db!.run(table.create(ifNotExists:true){ t in
                t.column(id, primaryKey: true)
                t.column(tittle)
                t.column(date)
                t.column(descripcion)
                
                })
            
        }catch{
            db = nil
        }
        
    }
    
    func insert(n:Nota)->Int64{
        let insert = table.insert(tittle <- n.title, date <- n.date, descripcion <- n.descripcion)
        
        do{
            return try db.run(insert)
        }catch{
            return -1
        }
    }
    
    func update(n:Nota){
        let filter = table.filter(id == n.id)
        let update = filter.update(tittle <- n.title, date <- n.date, descripcion <- n.descripcion)
        
        do{
            try db.run(update)
        }catch{
        }
        
    }
    
    func delete(n:Nota){
        let filter = table.filter(id == n.id)
        do{
            try db.run(filter.delete())
        }catch{
        }
        
        
    }
    
    func findById(idNota:Int64)->Nota?{
        let filter = table.filter(id == idNota)
        let data = db.prepare(filter)
        var row:Row?
        
        
        for r  in data {
            row = r
            break
        }
        
        return rowToNota(row)
    }
    
    func getAll()->[Nota]{
        return rowsToList(db.prepare(table))
        
    }
    
    func deleteDataTable() -> Void{
        do{
        try db.execute("DELETE FROM nota")
        }
        catch {
            NSLog("No elimino")
        }
    }
    
    /*func getAllByNombre(nombre:String)->[Planeta]{
        
        return statementToList(db.prepare("SELECT * FROM planeta WHERE nombre LIKE '%\(nombre)%'",nil))
    }*/
    
    
    
    private func rowsToList(rows:AnySequence<Row>)->[Nota]{
        var data:[Nota] = [Nota]()
        
        for r in rows{
            data.append(rowToNota(r)!)
        }
        
        return data
    }
    
    private func rowToNota(row:Row? )->Nota?{
        if row == nil{
            return nil
        }else{
            let n:Nota =  Nota()
            n.id = row![id]
            n.title = row![tittle]
            n.descripcion = row![descripcion]
            n.date = row![date]
            return n
        }
    }
    
    private func statementToList(s:Statement)->[Nota]{
        var data:[Nota] = [Nota]()
        
        for r in s{
            let n:Nota = Nota()
            n.id = r[0] as! Int64
            n.title = "\(r[1])"
            n.date = "\(r[2])"
            n.descripcion = "\(r[3])"
            
            data.append(n)
        }
        
        return data
        
    }
}