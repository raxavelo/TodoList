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
  @IBOutlet weak var taskView: UIStackView!
  
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
      case .work:
        categoryImageView.image = UIImage(systemName: "list.bullet.rectangle.portrait")
      case .others:
        categoryImageView.widthAnchor.constraint(equalToConstant: 0.0).isActive = true
        categoryImageView.isHidden = false
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    taskView.layer.cornerRadius = 10.0
    checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
