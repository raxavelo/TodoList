//
//  TodoTableViewController.swift
//  TodoList
//
//  Created by Grzegorz Zadkowski on 25/05/2022.
//

import UIKit
import RealmSwift

class TodoTableViewController: SwipeTableViewController {
  
  var realm = try! Realm()
  var tasks: Results<Task>?
  
  // MARK: - View lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor(named: "backgroundColor")
    tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "taskCell")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: true)
    loadTasks()
  }
  
  
  private func loadTasks() {
    tasks = realm.objects(Task.self)
    tableView.reloadData()
  }
  
  // MARK: - Table view data source methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let tasksCount = tasks?.count ?? 0
    return tasksCount > 0 ? tasksCount : 1
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath) as! TaskCell
    let tasksCount = tasks?.count ?? 0
    
    if tasksCount > 0 {
      if let task = tasks?[indexPath.row] {
        cell.isCompleted = task.isCompleted
        cell.category = Categories(string: task.category)
        cell.taskLabel.text = task.text
        cell.taskLabel.textColor = UIColor.white
        cell.dateLabel.text = task.date.formatted(date: .numeric, time: .shortened)
        cell.checkmarkImageView.isHidden = false
        cell.dateLabel.isHidden = false
        cell.isUserInteractionEnabled = true
      }
    } else {
      cell.taskLabel.text = "Brak zadań do wykonania"
      cell.taskLabel.textColor = UIColor.black
      cell.taskView.backgroundColor = UIColor.white
      cell.categoryImageView.isHidden = true
      cell.checkmarkImageView.isHidden = true
      cell.dateLabel.isHidden = true
      cell.isUserInteractionEnabled = false
    }
    
    return cell
  }
  
  // MARK: - Table view delegate methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    do {
      try realm.write {
        tasks?[indexPath.row].isCompleted.toggle()
        let cell = tableView.cellForRow(at: indexPath) as! TaskCell
        cell.isCompleted.toggle()
      }
    } catch {
      print(error.localizedDescription)
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // MARK: - SwipeTableViewController methods
  
  override func updateModel(at indexPath: IndexPath) {
    super.updateModel(at: indexPath)
    
    if let task = tasks?[indexPath.row] {
      do {
        try realm.write {
          realm.delete(task)
        }
        tableView.reloadData()
      } catch {
        print("Error deleting task, \(error.localizedDescription)")
      }
    }
    
  }
  
}
