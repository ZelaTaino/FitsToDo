//
//  EditTaskViewController.swift
//  FitsToDo
//
//  Created by Glizela Taino on 2/26/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit
import RealmSwift

class EditTaskViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var hasDateSwitch: UISwitch!
    @IBOutlet weak var highPriority: UIButton!
    @IBOutlet weak var mediumPriority: UIButton!
    @IBOutlet weak var lowPriority: UIButton!
    @IBOutlet weak var noPriority: UIButton!
    var hasDueDate = false
    var date = ""
    var priorityVal = 0
    var item = ToDoItem()
    var taskIndex = -1
    let realm = try! Realm()
    var todoList: Results<ToDoItem>{
        get{
            return realm.objects(ToDoItem.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        item = todoList[taskIndex]
        
        titleTextField.text = item.detail
        datePicker.isHidden = !item.hasDueDate
        hasDateSwitch.isOn = item.hasDueDate
        
        hasDueDate = item.hasDueDate
        date = item.date
        priorityVal = item.priorityVal
        
        switch item.priorityVal.hashValue {
        case ToDoItem.priority.high.hashValue:
            highPriority.isSelected = true
        case ToDoItem.priority.medium.hashValue:
            mediumPriority.isSelected = true
        case ToDoItem.priority.low.hashValue:
            lowPriority.isSelected = true
        default:
            noPriority.isSelected = true
        }
    }
    
    @IBAction func highPressed(_ sender: UIButton) {
        selectPriority(button: sender)
        priorityVal = ToDoItem.priority.high.hashValue
    }
    
    @IBAction func mediumPressed(_ sender: UIButton) {
        selectPriority(button: sender)
        priorityVal = ToDoItem.priority.medium.hashValue
    }
    
    @IBAction func lowPressed(_ sender: UIButton) {
        selectPriority(button: sender)
        priorityVal = ToDoItem.priority.low.hashValue
    }
    
    @IBAction func nonePressed(_ sender: UIButton) {
        selectPriority(button: sender)
        priorityVal = ToDoItem.priority.none.hashValue
    }
    
    func selectPriority(button: UIButton){
        highPriority.isSelected = false
        mediumPriority.isSelected = false
        lowPriority.isSelected = false
        noPriority.isSelected = false
        
        button.isSelected = true
    }
    

    @IBAction func dateSwitched(_ sender: UISwitch) {
        hasDueDate = sender.isOn
        datePicker.isHidden = !sender.isOn
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        let dateString = dateFormatter.string(from: sender.date)
        date = dateString
    }
    
    @IBAction func donePressed(_ sender: Any) {
        try! self.realm.write {
            item.detail = titleTextField.text!
            item.hasDueDate = hasDueDate
            item.date = date
            item.priorityVal = priorityVal
        }
        print("title: \(item.detail)")
        print("hasDate: \(item.hasDueDate)")
        print("date: \(item.date)")
        print("priority value: \(item.priorityVal)")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
