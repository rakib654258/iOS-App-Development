//
//  AddToDoViewController.swift
//  ToDoList using CoreData
//
//  Created by macOS Mojave on 3/5/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    var previousVC = ViewController()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var switchLabel: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        let toDo = ToDo()
        toDo.iteam = textField.text!
        toDo.important = switchLabel.isOn
        
        previousVC.toDos.append(toDo)
        previousVC.tableView.reloadData()
        
        navigationController?.popViewController(animated: true)
    }
    
}
