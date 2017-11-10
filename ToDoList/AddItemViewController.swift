//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by Patrick Hayes on 11/9/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailField: UITextView!
    @IBOutlet weak var datePickerField: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = "Title of your To Do Item"
        detailField.text = "Enter the details of your To Do Item"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
