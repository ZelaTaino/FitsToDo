//
//  ToDoItem.swift
//  FitsToDo
//
//  Created by Glizela Taino on 2/26/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import RealmSwift

class ToDoItem: Object {
    dynamic var detail = ""
    dynamic var status = 0
    dynamic var hasDueDate = false
    dynamic var date = ""
    dynamic var priorityVal = ToDoItem.priority.none.hashValue
    enum priority{
        case high
        case medium
        case low
        case none
    }
}
