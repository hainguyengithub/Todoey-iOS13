//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

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
    // var item = Item(context: self.context)
    // item.title = "placeholder"
    // item.isDone = true
    // self.itemArray.append(item)
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
    
    // Delete example
    // The order is important.
    // self.context.delete(self.itemArray[indexPath.row])
    // self.itemArray.remove(at: indexPath.row)
    // self.saveData()
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

  func loadData(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
    do {
      try self.itemArray = self.context.fetch(request)
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

extension TodoListViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    let request: NSFetchRequest<Item> = Item.fetchRequest()
    request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
    request.sortDescriptors = [
      NSSortDescriptor(key: "title", ascending: true)
    ]
    self.loadData(with: request)
    self.reloadData()
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if (searchBar.text?.count == 0) {
      self.loadData()
      DispatchQueue.main.async {
        searchBar.resignFirstResponder()
        self.reloadData()
      }
    }
  }

}
