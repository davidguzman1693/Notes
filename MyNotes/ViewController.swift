//
//  ViewController.swift
//  MyNotes
//
//  Created by Aplimovil on 12/8/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    
    var data:[Nota]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let fecha:NSDate = NSDate()
        data = [Nota(title:"Primera nota",date:"fecha1"),Nota(title:"Segunda nota",date:"fecha2"),Nota(title:"Tercera nota",date:"fecha3")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    }
    
    @IBAction func goToBack(segue: UIStoryboardSegue){
        NSLog("Regreso")
    }

}

