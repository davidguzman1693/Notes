//
//  ViewController.swift
//  MyNotes
//
//  Created by Aplimovil on 12/8/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    
    var data:[Nota]=[Nota]()
    
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let fecha:NSDate = NSDate()
        /*data = [Nota(title:"Primera nota",date:"fecha1",descripcion: "Descripcion 1"),Nota(title:"Segunda nota",date:"fecha2",descripcion: "Descripcion 1"),Nota(title:"Tercera nota",date:"fecha3",descripcion: "Descripcion 1")]*/
        var n = Nota()
        n.title="Nota 1"
        n.descripcion="Descripcion 1"
        n.date = "Fecha 1"
        n.id=1
        data.append(n)
        
        n = Nota()
        n.title="Nota 2"
        n.descripcion="Descripcion 2"
        n.date = "Fecha 2"
        n.id=2
        data.append(n)
        
        n = Nota()
        n.title="Nota 3"
        n.descripcion="Descripcion 3"
        n.date = "Fecha 3"
        n.id=3
        data.append(n)
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
        
        cell.title.text = data[pos].title
        cell.date.text = data[pos].date
        /*let formatter:NSDateFormatter = NSDateFormatter()
        
        cell.date.text = formatter.stringFromDate(data[pos].date)
        */
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToNewNote"{
            
            let p2:NuevaNotaViewController = segue.destinationViewController as! NuevaNotaViewController
                p2.data = "hola"
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

}

