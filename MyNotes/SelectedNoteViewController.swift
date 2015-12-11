//
//  SelectedNoteViewController.swift
//  MyNotes
//
//  Created by Aplimovil on 12/9/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit

class SelectedNoteViewController: UIViewController {


    @IBOutlet var tittle: UITextField!
    @IBOutlet var desc: UITextView!
    var list:ViewController!
    @IBOutlet var edit: UIBarButtonItem!
    @IBOutlet var acept: UIBarButtonItem!
    @IBOutlet var delete: UIBarButtonItem!
    var pos:Int!
    var notaDao:NoteDao!
    override func viewDidLoad() {
        super.viewDidLoad()
        tittle.text = list.data[pos].title
        desc.text = list.data[pos].descripcion
        notaDao = NoteDao()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func editNote(sender: AnyObject) {
        delete.enabled = false
        edit.enabled = false
        acept.enabled = true
        tittle.enabled = true
        desc.editable = true
    }
    @IBAction func deleteNote(sender: AnyObject) {
        let alert:UIAlertController = UIAlertController(title: "Eliminar Nota", message: "Desea eliminar la nota " + list.data[pos].title, preferredStyle: UIAlertControllerStyle.Alert)
        
        let actionOk:UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.notaDao.delete(self.list.data[self.pos])
            self.list.data.removeAtIndex(self.pos)

            self.navigationController?.popToViewController(self.list, animated: true)
        }
        
        let actionCancel:UIAlertAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        
        presentViewController(alert, animated: true, completion: nil)

    }
    @IBAction func aceptEditNote(sender: AnyObject) {
        
        if(tittle.text == "" || desc.text == ""){
            let alert:UIAlertController = UIAlertController(title: "Error", message: "Debes llenar todos los campos", preferredStyle: UIAlertControllerStyle.Alert)
            
            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            alert.addAction(action)
            
            
            presentViewController(alert, animated: true, completion: nil)
            
        }else{
        list.data[pos].title = tittle.text
        list.data[pos].descripcion = desc.text
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        list.data[pos].date = "\(formatter.stringFromDate(date))"
        notaDao.update(list.data[pos])
        self.navigationController?.popToViewController(list, animated: true)
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
