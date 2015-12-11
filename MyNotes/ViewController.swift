//
//  ViewController.swift
//  MyNotes
//
//  Created by Aplimovil on 12/8/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit
import Parse
class ViewController: UIViewController, UITableViewDataSource {
    
    
    var data:[Nota]=[Nota]()
    var data1:[Nota]=[Nota]()
    var notaDao:NoteDao!
    @IBOutlet var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var filteredNotes = [Nota]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Se trae los datos de SQLite
        notaDao = NoteDao()
//        data = notaDao.getAll()
        notaDao.deleteDataTable()
        
        
        //Se trae los datos de Parse
        let query = PFQuery(className: "Nota")
        query.whereKey("IDUser", equalTo:"1")
        query.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                var n:Nota
                if let objects = objects {
                    for object in objects{
                        n = Nota()
                        n.idParse = object.objectId
                        let date:NSDate? = object.updatedAt
                        let formatter = NSDateFormatter()
                        formatter.dateFormat = "yyyy/MM/dd HH:mm"
                        n.date = "\(formatter.stringFromDate(date!))"
                        n.title = object["Titulo"] as! String
                        n.descripcion = object["Descripcion"] as! String
                        self.data1.append(n)
                    }
                }
                self.verificarDatosEnParseYSQLite()
            }
            else{
                let alert:UIAlertController = UIAlertController(title: "Verifica tu conexion a Internet", message: "Solo se han podido cargar los datos locales", preferredStyle: UIAlertControllerStyle.Alert)
                
                let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }
        
        
        //Parametrizar la busqueda
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        table.tableHeaderView = searchController.searchBar
        
        
        
        }

    //Funcion que verifica datos de Parse y SQLite
    
    func verificarDatosEnParseYSQLite(){
        if(data.count == 0){
            data = data1
            table.reloadData()
           }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell : CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("celda") as! CustomTableViewCell
        
        let pos = indexPath.row
        let note: Nota
        if searchController.active && searchController.searchBar.text != "" {
            note = filteredNotes[pos]
        } else {
            note = data[pos]
        }
        cell.title.text = note.title
        cell.date.text = note.date
        /*let formatter:NSDateFormatter = NSDateFormatter()
        
        cell.date.text = formatter.stringFromDate(data[pos].date)
        */
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredNotes.count
        }
        return data.count
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToNewNote"{
            
            let p2:NuevaNotaViewController = segue.destinationViewController as! NuevaNotaViewController
            p2.list = self

        }
        else if(segue.identifier == "goToSelectedNote"){
            let p2:SelectedNoteViewController = segue.destinationViewController as! SelectedNoteViewController
            p2.pos = table.indexPathForSelectedRow!.row
            p2.list = self
                 }

    }
    
    @IBAction func goToBack(segue: UIStoryboardSegue){
        NSLog("Regreso")
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredNotes = data.filter { note in
            return note.title.lowercaseString.containsString(searchText.lowercaseString)
            
        }
        table.reloadData()
    }
    
  

}

extension  ViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        
    }
}

