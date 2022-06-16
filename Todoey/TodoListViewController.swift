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

  let userDefaults = UserDefaults.standard

  override func viewDidLoad() {
    super.viewDidLoad()
    if let items = self.userDefaults.array(forKey: "TodoListArray") as? [String] {
      self.itemArray = items
    }
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

  //MARK - add new item

  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
    alert.addTextField { alertTextField in
      alertTextField.placeholder = "A todo item"
    }
    let addAction = UIAlertAction(title: "Add", style: .default) { action in
      if let textfield = alert.textFields?[0] {
        if let value = textfield.text {
          self.itemArray.append(value)
          self.userDefaults.set(self.itemArray, forKey: "TodoListArray")
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
        }
      }

      // self.itemArray.append()
    }
    alert.addAction(addAction)
    self.present(alert, animated: true, completion: nil)
  }
  

}
