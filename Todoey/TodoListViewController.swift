//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

  var itemArray = [
    "Find Mike",
    "Buy Eggos",
    "Destroy Demogorgon"
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  //MARK - Table view data source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.itemArray.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
    cell.textLabel?.text = self.itemArray[indexPath.row]
    return cell
  }

  //MARK - table view delegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if (self.tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
      self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
    } else {
      self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }

    self.tableView.deselectRow(at: indexPath, animated: true)
  }

}
