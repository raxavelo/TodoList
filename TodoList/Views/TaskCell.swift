//
//  TaskCell.swift
//  TodoList
//
//  Created by Grzegorz Zadkowski on 24/05/2022.
//

import UIKit
import SwipeCellKit

class TaskCell: SwipeTableViewCell {
  
  @IBOutlet weak var categoryImageView: UIImageView!
  @IBOutlet weak var checkmarkImageView: UIImageView!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var taskLabel: UILabel!
  @IBOutlet weak var taskView: UIView!
  
  var isCompleted: Bool = false {
    didSet {
      checkmarkImageView.image = UIImage(systemName: isCompleted ? "checkmark.diamond": "diamond")
    }
  }
  
  var category: Categories? {
    didSet {
      categoryImageView.isHidden = false
      
      switch category {
      case .shop:
        categoryImageView.image = UIImage(systemName: "cart")
        taskView.backgroundColor = UIColor(named: "shopColor")
      case .work:
        categoryImageView.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        taskView.backgroundColor = UIColor(named: "workColor")
      case .others, .none:
        categoryImageView.isHidden = true
        taskView.backgroundColor = UIColor(named: "othersColor")
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    makeLayout()
  }
  
  private func makeLayout() {
    taskView.layer.cornerRadius = 20.0
    taskView.layer.shadowRadius = 3.0
    taskView.layer.shadowOpacity = 0.3
    checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
  }
}
