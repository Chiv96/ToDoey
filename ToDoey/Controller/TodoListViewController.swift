//
//  TodoListViewController.swift
//  ToDoey
//
//  Created by Chivonne Reji on 30/03/21.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let userDefaultsObject = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = Item()
        item1.title = "Buy shoes"
        
        let item2 = Item()
        item2.title = "Call home"
        
        let item3 = Item()
        item3.title = "Exercise"
        
        itemArray.append(item1)
        itemArray.append(item2)
        itemArray.append(item3)
        
//        if let items = userDefaultsObject.array(forKey: "ToDoListItemArray") as? [Item] {
//            itemArray = items
//        }
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
        if item.done {
            item.done = false
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            item.done = true
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .some(.checkmark) {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
    }
    
    @IBAction func addNewTodo(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "New ToDoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add new item", style: .default) { (action) in
            if let newItem = textField.text {
                let newItemObj = Item()
                newItemObj.title = newItem
                self.itemArray.append(newItemObj)
//                self.userDefaultsObject.set(self.itemArray, forKey: "ToDoListItemArray")
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}

