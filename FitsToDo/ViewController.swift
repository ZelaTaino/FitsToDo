//
//  ViewController.swift
//  FitsToDo
//
//  Created by Glizela Taino on 2/25/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
//    var editedRow = -1
    // declare realm object
    let realm = try! Realm()
    // get items in database
    var todoList: Results<ToDoItem>{
        get{
            return realm.objects(ToDoItem.self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        let item = todoList[indexPath.row]
        cell.textLabel!.text = item.detail
        cell.detailTextLabel!.text = String(item.status)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = todoList[indexPath.row]
        try! self.realm.write({
            if(item.status == 0){
                item.status = 1
            }else{
                item.status = 0
            }
        })
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit"){
            (rowAction, indexPath) in
//            self.editedRow = indexPath.row
            self.performSegue(withIdentifier: "showEditTaskViewController", sender: indexPath.row)
        }
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete"){
            (rowAction, datindexPath) in
            // delete specific items from database
            let item = self.todoList[indexPath.row]
            try! self.realm.write({
                self.realm.delete(item)
            })
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        editAction.backgroundColor = UIColor.lightGray
        return[deleteAction, editAction]
    }
    
    @IBAction func addNewPressed(_ sender: UIButton) {
        let alertController: UIAlertController = UIAlertController(title: "New To Do", message: "What task would you like to add?", preferredStyle: .alert)
        
        alertController.addTextField { (UITextField) in
            
        }
     
        let action_cancel = UIAlertAction.init(title: "Cancel", style: .cancel){(UIAlertAction) -> Void in}
        
        alertController.addAction(action_cancel)
        
        let action_add = UIAlertAction.init(title: "Add", style: .default){(UIAlertAction)-> Void in
            let textField_todo = (alertController.textFields?.first)! as UITextField
            print("You entered \(textField_todo.text)")
            let todoItem = ToDoItem()
            todoItem.detail = textField_todo.text!
            todoItem.status = 0
            
            try! self.realm.write({
                self.realm.add(todoItem)
                self.tableView.insertRows(at: [IndexPath.init(row: self.todoList.count-1, section: 0)], with: .automatic)
            })
        }
        
        alertController.addAction(action_add)
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showEditTaskViewController"){
            let navController = segue.destination as! UINavigationController
            let editTaskView = navController.topViewController as! EditTaskViewController
            editTaskView.taskIndex = sender as! Int

        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

