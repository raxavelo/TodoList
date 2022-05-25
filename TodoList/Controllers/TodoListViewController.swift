//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Grzegorz Zadkowski on 24/05/2022.
//

import UIKit

class TodoListViewController: UIViewController {
  
  @IBOutlet weak var addTaskButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "taskCell")
    addButtonShadow()
  }

  private func addButtonShadow() {
    addTaskButton.layer.shadowRadius = 10.0
    addTaskButton.layer.shadowOpacity = 0.3
  }
  
  @IBAction func addTaskButtonTapped(_ sender: UIButton) {
    
  }
  
}


extension TodoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
    cell.isCompleted = true
    cell.category = .work
    cell.taskLabel.text = "Zniszczyć Demogorgona"
    cell.dateLabel.text = "28.11.2023 r."
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    2
  }
  
}

extension TodoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
}
