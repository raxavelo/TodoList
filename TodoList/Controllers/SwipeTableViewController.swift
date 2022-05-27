//
//  SwipeTableView.swift
//  TodoList
//
//  Created by Grzegorz Zadkowski on 25/05/2022.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! SwipeTableViewCell
    cell.delegate = self
    return cell
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    guard orientation == .right else { return nil }
    
    let deleteAction = SwipeAction(style: .destructive, title: "Usuń") { _, indexPath in
      let alertController = UIAlertController(title: "Usunąć zadanie?", message: nil, preferredStyle: .alert)
      let confirmAction = UIAlertAction(title: "Tak", style: .destructive) { _ in
        self.updateModel(at: indexPath)
      }
      let cancelAction = UIAlertAction(title: "Nie", style: .cancel) { _ in
        let cell = tableView.cellForRow(at: indexPath) as! TaskCell
        cell.hideSwipe(animated: true)
      }
      alertController.addAction(cancelAction)
      alertController.addAction(confirmAction)
      self.present(alertController, animated: true)
    }
    
    deleteAction.image = UIImage(systemName: "trash.circle")
    
    return [deleteAction]
  }
  
  func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
    var options = SwipeOptions()
    options.expansionStyle = .selection
    options.transitionStyle = .drag
    return options
  }
  
  func updateModel(at indexPath: IndexPath) {
    
  }
}
