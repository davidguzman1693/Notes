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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
