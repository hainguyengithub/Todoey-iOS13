  //
  //  CategoryTableViewController.swift
  //  Todoey
  //
  //  Created by hainguyen on 2022-06-18.
  //  Copyright © 2022 App Brewery. All rights reserved.
  //

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

  var categories: [`Category`] = []

  let context = (UIApplication.shared.delegate as! AppDelegate)
    .persistentContainer
    .viewContext

  override func viewDidLoad() {
    super.viewDidLoad()
    self.loadData()
  }

  //MARK: - Table view data source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.categories.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: K.categoryCellIdentifier, for: indexPath)
    cell.textLabel?.text = self.categories[indexPath.row].name
    return cell
  }

  //MARK: - Data manipulation methods

  func saveData() {
    do {
      try context.save()
    } catch {
      print("Error saving the context \(error)")
    }
  }

  func loadData(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
    do {
      try self.categories = self.context.fetch(request)
    } catch {
      print("Error encoding the data \(error)")
    }
  }

  func reloadData() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  //MARK: - Add new categories

  @IBAction func addButtonPressed(_ sender: Any) {
    var textField = UITextField()
    let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
    let addAction = UIAlertAction(title: "Add", style: .default) { action in
      let newCategory = Category(context: self.context)
      newCategory.name = textField.text!
      self.categories.append(newCategory)
      self.saveData()
      self.reloadData()
    }
    alert.addAction(addAction)
    alert.addTextField { field in
      textField = field
      textField.placeholder = "Add new category"
    }
    self.present(alert, animated: true, completion: nil)
  }

  //MARK: - Table view delegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "showItems", sender: self)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! TodoListViewController
    if let indexPath = self.tableView.indexPathForSelectedRow {
      destinationVC.selectedCategory = self.categories[indexPath.row]
    }
  }

}
