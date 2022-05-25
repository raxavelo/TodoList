//
//  TaskCell.swift
//  TodoList
//
//  Created by Grzegorz Zadkowski on 24/05/2022.
//

import UIKit

class TaskCell: UITableViewCell {
  
  @IBOutlet weak var categoryImageView: UIImageView!
  @IBOutlet weak var checkmarkImageView: UIImageView!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var taskLabel: UILabel!
  @IBOutlet weak var taskView: UIView!
  
  var isCompleted: Bool = false {
    didSet {
      switch isCompleted {
      case true:
        checkmarkImageView.image = UIImage(systemName: "checkmark.diamond")
      case false:
        checkmarkImageView.image = UIImage(systemName: "diamond")
      }
    }
  }
  
  var category: Categories = .others {
    didSet {
      categoryImageView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
      categoryImageView.isHidden = false
      
      switch category {
      case .shop:
        categoryImageView.image = UIImage(systemName: "cart")
        taskView.backgroundColor = UIColor(named: "shopColor")
      case .work:
        categoryImageView.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        taskView.backgroundColor = UIColor(named: "workColor")
      case .others:
        categoryImageView.widthAnchor.constraint(equalToConstant: 0.0).isActive = true
        categoryImageView.isHidden = false
        taskView.backgroundColor = UIColor(named: "othersColor")
      }
      
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    makeLayout()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  private func makeLayout() {
    taskView.layer.cornerRadius = 20.0
    taskView.layer.shadowRadius = 3.0
    taskView.layer.shadowOpacity = 0.3
    checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
    contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
  }
}
