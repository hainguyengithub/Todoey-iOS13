//
//  Item.swift
//  Todoey
//
//  Created by hainguyen on 2022-06-16.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

class Item: Codable {

  var title: String = ""

  var isDone: Bool = false

  init(title: String = "", isDone: Bool = false) {
    self.title = title
    self.isDone = isDone
  }

}
