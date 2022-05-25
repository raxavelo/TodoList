//
//  AddTaskViewController.swift
//  TodoList
//
//  Created by Grzegorz Zadkowski on 25/05/2022.
//

import UIKit

class AddTaskViewController: UIViewController {
  
  @IBOutlet weak var categoryPicker: UISegmentedControl!
  var category: Categories = .work
  
  override func viewDidLoad() {
    super.viewDidLoad()
    categoryPicker.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    categoryPicker.addTarget(self, action: #selector(handlePicker), for: .valueChanged)
  }
  
  @objc private func handlePicker() {
    switch categoryPicker.selectedSegmentIndex {
    case 0:
      category = .work
    case 1:
      category = .shop
    default:
      category = .others
    }
    print(category)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
