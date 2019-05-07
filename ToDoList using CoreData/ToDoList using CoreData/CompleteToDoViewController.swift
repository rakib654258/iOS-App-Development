//
//  CompleteToDoViewController.swift
//  ToDoList using CoreData
//
//  Created by macOS Mojave on 3/5/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class CompleteToDoViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    var previousVC = ViewController()
    var selectedToDo = ToDo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = selectedToDo.iteam
    }
    
    @IBAction func completeAction(_ sender: UIButton) {
        var index = 0
        for toDo in previousVC.toDos{
            if toDo.iteam == selectedToDo.iteam{
                //print("We found it! \(toDo.iteam) \(index)")
                previousVC.toDos.remove(at: index)
                previousVC.tableView.reloadData()
                navigationController?.popViewController(animated: true)
                //break
            }
            index += 1
        }
    }
    
}
