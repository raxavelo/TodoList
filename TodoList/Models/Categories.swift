//
//  Categories.swift
//  TodoList
//
//  Created by Grzegorz Zadkowski on 24/05/2022.
//

import Foundation

enum Categories: String {
  case work, shop, others
  
  init(string: String) {
    let value = string.lowercased()
    switch value {
    case "work":
      self = .work
    case "shop":
      self = .shop
    default:
      self = .others
    }
  }
}
