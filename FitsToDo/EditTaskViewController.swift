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
    @IBOutlet weak var titleTextField: UITextField!
    var taskIndex = -1
    let realm = try! Realm()
    var todoList: Results<ToDoItem>{
        get{
            return realm.objects(ToDoItem.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let item = todoList[taskIndex]
        titleTextField.text = item.detail
    }

    @IBAction func datePicker(_ sender: UIDatePicker) {
        
        
        
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
