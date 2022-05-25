//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Grzegorz Zadkowski on 24/05/2022.
//

import UIKit
import RealmSwift

class TodoListViewController: UIViewController {
  
  @IBOutlet weak var addTaskButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  
  var realm = try! Realm()
  
  var tasks: Results<Task>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "taskCell")
    addButtonShadow()
    loadTasks()
  }
  
  private func addButtonShadow() {
    addTaskButton.layer.shadowRadius = 10.0
    addTaskButton.layer.shadowOpacity = 0.3
  }
  
  private func loadTasks() {
    tasks = realm.objects(Task.self)
    tableView.reloadData()
  }
  
  @IBAction func addTaskButtonTapped(_ sender: UIButton) {
    
  }
  
}


extension TodoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
    guard tasks?.count ?? 0 > 0 else {
      cell.taskView.backgroundColor = UIColor.white
      cell.categoryImageView.isHidden = true
      cell.checkmarkImageView.isHidden = true
      cell.dateLabel.isHidden = true
      cell.taskLabel.text = "Brak zadań do wykonania"
      cell.taskLabel.textColor = UIColor(named: "othersColor")
      return cell
    }
    
    
    
    if let task = tasks?[indexPath.row] {
      cell.isCompleted = task.isCompleted
      cell.category = Categories(string: task.category)
      cell.taskLabel.text = task.text
      cell.dateLabel.text = task.date.description
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let taskCount = tasks?.count, taskCount > 0 {
      return taskCount
    } else {
      return 1
    }
  }
  
}

extension TodoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
}
