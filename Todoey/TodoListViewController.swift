//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

  var itemArray: [Item] = [
    Item(title: "Find Mike"),
    Item(title: "Buy Eggos"),
    Item(title: "Destroy Demogorgon"),
    Item(title: "Save the world"),
  ]

  let dataFilePath = FileManager
    .default
    .urls(for: .documentDirectory, in: .userDomainMask)
    .first?
    .appendingPathComponent("Items.plist")

  // let userDefaults = UserDefaults.standard

  override func viewDidLoad() {
    super.viewDidLoad()
    self.loadData()
  }

  //MARK - Table view data source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.itemArray.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
    cell.accessoryType = (itemArray[indexPath.row].isDone) ? .checkmark : .none
    cell.textLabel?.text = self.itemArray[indexPath.row].title
    return cell
  }

  //MARK - table view delegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone
    self.saveData()
    self.reloadData()
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
          let newItem = Item(title: value)
          self.itemArray.append(newItem)
          self.saveData()
          self.reloadData()
        }
      }

      // self.itemArray.append()
    }
    alert.addAction(addAction)
    self.present(alert, animated: true, completion: nil)
  }

  func saveData() {
    let encoder = PropertyListEncoder()
    do {
      let data = try encoder.encode(self.itemArray)
      try data.write(to: self.dataFilePath!)
    } catch {
      print("Error encoding the data \(error)")
    }
  }

  func loadData() {
    let decoder = PropertyListDecoder()
    do {
      let data = try Data(contentsOf: dataFilePath!)
      let items = try decoder.decode([Item].self, from: data)
      self.itemArray = items
    } catch {
      print("Error encoding the data \(error)")
    }
  }

  func reloadData() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

}
