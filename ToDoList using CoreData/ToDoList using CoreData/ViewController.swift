//
//  ViewController.swift
//  ToDoList using CoreData
//
//  Created by macOS Mojave on 3/5/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var toDos : [ToDo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //toDos = createToDos()
    }
//    func createToDos() -> [ToDo]{
//        let eggs = ToDo()
//        eggs.iteam = "Buy Eggs"
//        eggs.important = true
//
//        let milk = ToDo()
//        milk.iteam = "Buy milk 1 litter"
//
//        return [eggs, milk]
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! customTableViewCell
        let toDo = toDos[indexPath.row]
        if toDo.important{
            cell.iteamLabel.text = "⭐️" + toDo.iteam
        }
        else{
            cell.iteamLabel.text = toDo.iteam
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "completeSegue", sender: toDo)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoViewController{
            addVC.previousVC = self
        }
        if let completeVC = segue.destination as? CompleteToDoViewController{
            if let toDo = sender as? ToDo{
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
    }
    

}

