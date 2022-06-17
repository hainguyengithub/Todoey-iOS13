//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

  var itemArray: [Item] = []

  let dataFilePath = FileManager
    .default
    .urls(for: .documentDirectory, in: .userDomainMask)
    .first?
    .appendingPathComponent("Items.plist")

  let context = (UIApplication.shared.delegate as! AppDelegate)
    .persistentContainer
    .viewContext

  override func viewDidLoad() {
    super.viewDidLoad()
    var item = Item(context: self.context)
    item.title = "placeholder"
    item.isDone = true
    self.itemArray.append(item)
    print(self.tableView!)
    // self.loadData()
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
          let newItem = Item(context: self.context)
          newItem.title = value
          newItem.isDone = false
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
    do {
      try context.save()
    } catch {
      print("Error saving the context \(error)")
    }
  }

  // func loadData() {
  //   do {
  //
  //   } catch {
  //     print("Error encoding the data \(error)")
  //   }
  // }

  func reloadData() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

}
