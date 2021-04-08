//
//  TodoListViewController.swift
//  ToDoey
//
//  Created by Chivonne Reji on 30/03/21.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = itemArray[indexPath.row]
        item.done = !item.done
        self.saveDataToFile()
    }
    
    @IBAction func addNewTodo(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "New ToDoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add new item", style: .default) { (action) in
            if let newItem = textField.text {
                let newItemObj = Item(context: self.context)
                newItemObj.title = newItem
                self.itemArray.append(newItemObj)
                self.saveDataToFile()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func saveDataToFile() {
        do {
            try context.save()
        } catch {
            print("Error occured while saving context: \(error)")
        }
        self.tableView.reloadData()
    }
}

