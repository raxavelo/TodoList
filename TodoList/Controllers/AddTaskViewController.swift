//
//  AddTaskViewController.swift
//  TodoList
//
//  Created by Grzegorz Zadkowski on 25/05/2022.
//

import UIKit
import RealmSwift

class AddTaskViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var categoryPicker: UISegmentedControl!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var taskTextView: UITextView!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  // MARK: - Properties
  
  let realm = try! Realm()
  var category: Categories = .work
  
  // MARK: - View Lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    taskTextView.delegate = self
    
    categoryPicker.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    categoryPicker.addTarget(self, action: #selector(handlePicker), for: .valueChanged)
    
    let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(tap))
    tapGestureReconizer.cancelsTouchesInView = false
    view.addGestureRecognizer(tapGestureReconizer)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: true)
    makeLayout()
  }
  
  override func viewWillLayoutSubviews() {
    var constraints = view.constraints
    
    NSLayoutConstraint.deactivate(constraints)
    
    let addButtonLeadingConstraintIndex = constraints.firstIndex { constraint in
      constraint.identifier == "addButtonLeadingConstraint"
    }
    let addButtonBottomConstraintIndex = constraints.firstIndex { constraint in
      constraint.identifier == "addButtonBottomConstraint"
    }
    
    
    if traitCollection.verticalSizeClass == .compact {
      // Landscape
      
      // Delete cancelButton trailing constraint
      constraints.removeAll { constraint in
        constraint.identifier == "cancelButtonTrailingConstraint"
      }
      // addButton.leading = cancelButton.trailing + 10
      constraints[addButtonLeadingConstraintIndex!] = addButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 10)
      constraints[addButtonLeadingConstraintIndex!].identifier = "addButtonLeadingConstraint"
      // addButton.bottom = cancelButton.bottom
      constraints[addButtonBottomConstraintIndex!] = addButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor)
      constraints[addButtonBottomConstraintIndex!].identifier = "addButtonBottomConstraint"
    } else {
      // Portrait
      
      // cancelButton.trailing = safeArea.trailing - 10
      let cancelButtonTrailingConstraint = cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
      cancelButtonTrailingConstraint.identifier = "cancelButtonTrailingConstraint"
      constraints += [cancelButtonTrailingConstraint]
      // addButton.leading = safeArea.leading + 10
      constraints[addButtonLeadingConstraintIndex!] = addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
      constraints[addButtonLeadingConstraintIndex!].identifier = "addButtonLeadingConstraint"
      // addButton.bottom = cancelButton.top - 5
      constraints[addButtonBottomConstraintIndex!] = addButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -5)
      constraints[addButtonBottomConstraintIndex!].identifier = "addButtonBottomConstraint"
    }
    
    NSLayoutConstraint.activate(constraints)
  }
  
  // MARK: - Other methods
  
  private func makeLayout() {
    taskTextView.translatesAutoresizingMaskIntoConstraints = false
    categoryLabel.translatesAutoresizingMaskIntoConstraints = false
    categoryPicker.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    addButton.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    
    var constraints: [NSLayoutConstraint] = []
    
    // MARK: Static Constraints
    
    // taskTextView
    // top = safeArea.top + 10
    constraints += [taskTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)]
    // leading = safeArea.leading + 10
    constraints += [taskTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)]
    // trailing = safeArea.trailing - 10
    constraints += [taskTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)]
    // height = 100
    constraints += [taskTextView.heightAnchor.constraint(equalToConstant: 100)]
    
    // categoryLabel
    // top = taskTextView.bottom + 15
    constraints += [categoryLabel.topAnchor.constraint(equalTo: taskTextView.bottomAnchor, constant: 15)]
    // leading = taskTextView.leading
    constraints += [categoryLabel.leadingAnchor.constraint(equalTo: taskTextView.leadingAnchor)]
    // trailing = taskTextView.trailing
    constraints += [categoryLabel.trailingAnchor.constraint(equalTo: taskTextView.trailingAnchor)]
    // height = 21
    constraints += [categoryLabel.heightAnchor.constraint(equalToConstant: 21)]
    
    // categoryPicker
    // top = categoryLabel.bottom + 5
    constraints += [categoryPicker.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5)]
    // leading = taskTextView.leading
    constraints += [categoryPicker.leadingAnchor.constraint(equalTo: taskTextView.leadingAnchor)]
    // trailing = taskTextView.trailing
    constraints += [categoryPicker.trailingAnchor.constraint(equalTo: taskTextView.trailingAnchor)]
    // height = 30
    constraints += [categoryPicker.heightAnchor.constraint(equalToConstant: 30)]
    
    // dateLabel
    // top = categoryPicker.bottom + 15
    constraints += [dateLabel.topAnchor.constraint(equalTo: categoryPicker.bottomAnchor, constant: 15)]
    // leading = taskTextView.leading
    constraints += [dateLabel.leadingAnchor.constraint(equalTo: taskTextView.leadingAnchor)]
    // trailing = taskTextView.trailing
    constraints += [dateLabel.trailingAnchor.constraint(equalTo: taskTextView.trailingAnchor)]
    // height = 21
    constraints += [dateLabel.heightAnchor.constraint(equalToConstant: 21)]
    
    // datePicker
    // top = dateLabel.bottom + 5
    constraints += [datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5)]
    // centerX = view.centerX
    constraints += [datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
    // width = 250
    constraints += [datePicker.widthAnchor.constraint(equalToConstant: 250)]
    // height = 40
    constraints += [datePicker.heightAnchor.constraint(equalToConstant: 40)]
    
    // cancelButton
    // bottom = safeArea.bottom - 10
    constraints += [cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)]
    // leading = taskTextView.leading
    constraints += [cancelButton.leadingAnchor.constraint(equalTo: taskTextView.leadingAnchor)]
    // height = 50
    constraints += [cancelButton.heightAnchor.constraint(equalToConstant: 50)]
    
    // addButton
    // trailing = taskTextView.trailing
    constraints += [addButton.trailingAnchor.constraint(equalTo: taskTextView.trailingAnchor)]
    // height = cancelButton.height
    constraints += [addButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor)]
    // width = cancelButton.width
    constraints += [addButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor)]
    
    // MARK: Dynamic Constraints
    
    // cancelButton
    // trailing = safeArea.trailing - 10
    let cancelButtonTrailingConstraint = cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
    cancelButtonTrailingConstraint.identifier = "cancelButtonTrailingConstraint"
    
    // addButton
    // leading = safeArea.leading + 10
    let addButtonLeadingConstraint = addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
    addButtonLeadingConstraint.identifier = "addButtonLeadingConstraint"
    // bottom = cancelButton.top - 5
    let addButtonBottomConstraint = addButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -5)
    addButtonBottomConstraint.identifier = "addButtonBottomConstraint"
    
    constraints += [cancelButtonTrailingConstraint,
                    addButtonLeadingConstraint,
                    addButtonBottomConstraint]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  @objc private func tap(sender: UITapGestureRecognizer) {
    taskTextView.resignFirstResponder()
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
  }
  
  // MARK: - IBActions
  
  @IBAction func addPressed(_ sender: UIButton) {
    let task = Task()
    task.text = taskTextView.text!
    task.category = category.rawValue
    task.date = datePicker.date
    
    do {
      try realm.write {
        realm.add(task)
        
        let alert = UIAlertController(title: "Zadanie zostało dodane do listy", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
          self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
      }
    } catch {
      let alert = UIAlertController(title: "Błąd", message: "Nie udało się dadać nowego zadania. Spróbuj jeszcze raz.", preferredStyle: .alert)
      let action = UIAlertAction(title: "Ok", style: .default)
      alert.addAction(action)
      present(alert, animated: true, completion: nil)    }
  }
  
  @IBAction func cancelPressed(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
}


extension AddTaskViewController: UITextViewDelegate {
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.text = ""
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
      textView.resignFirstResponder()
      return false
    }
    return true
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    textView.resignFirstResponder()
  }
  
}
