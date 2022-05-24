//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Grzegorz Zadkowski on 24/05/2022.
//

import UIKit

class TodoListViewController: UIViewController {
  
  @IBOutlet weak var addTaskButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addButtonShadow()
  }

  private func addButtonShadow() {
    addTaskButton.layer.shadowRadius = 10.0
    addTaskButton.layer.shadowOpacity = 0.3
  }
  @IBAction func addTaskButtonTapped(_ sender: UIButton) {
    
  }
  
}
