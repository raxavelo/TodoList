//
//  Task.swift
//  TodoList
//
//  Created by Grzegorz Zadkowski on 25/05/2022.
//

import RealmSwift
import Foundation

class Task: Object {
  @Persisted(primaryKey: true) var _id: ObjectId
  @Persisted var text = ""
  @Persisted var isCompleted = false
  @Persisted var category = ""
  @Persisted var date = Date()
  @Persisted var timestamp = Date()
}
