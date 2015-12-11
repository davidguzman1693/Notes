//
//  NuevaNotaViewController.swift
//  MyNotes
//
//  Created by Aplimovil on 12/8/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit
import Parse
class NuevaNotaViewController: UIViewController {

    @IBOutlet var tittle: UITextField!
    @IBOutlet var desc: UITextView!
    var data:String!
    var notaDao:NoteDao!
    var list:ViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desc.text = data
        tittle.text = data
        notaDao = NoteDao()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addNote(sender: AnyObject) {
        
        if(tittle.text == "" || desc.text == ""){
            let alert:UIAlertController = UIAlertController(title: "Error", message: "Debes llenar todos los campos", preferredStyle: UIAlertControllerStyle.Alert)
            
            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            alert.addAction(action)
            
            presentViewController(alert, animated: true, completion: nil)

        }
        else{
            let n:Nota = Nota()
            n.title = tittle.text
            n.descripcion = desc.text
            let date = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            n.date = "\(formatter.stringFromDate(date))"
            //Guarda en SQLite
            notaDao.insert(n)
            //Guarda en Parse
            let nota = PFObject(className: "Nota")
            nota["Titulo"] = tittle.text
            nota["Descripcion"] = desc.text
            nota["IDUser"] = "1"
            nota.saveInBackgroundWithBlock { (success: Bool!, error: NSError?) -> Void in
                if(success != nil){
                    n.idParse = nota.objectId
                }
                else{
                    NSLog("\(error)")
                }
            }
            //Añade a lista
            list.data.append(n)
            navigationController?.popToViewController(self.list, animated: true)
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
