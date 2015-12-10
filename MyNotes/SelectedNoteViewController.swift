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
    override func viewDidLoad() {
        super.viewDidLoad()
        tittle.text = list.data[pos].title
        desc.text = list.data[pos].descripcion
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
    }
    @IBAction func aceptEditNote(sender: AnyObject) {
        list.data[pos].title = tittle.text
        list.data[pos].descripcion = desc.text
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
