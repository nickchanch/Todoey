//
//  ViewController.swift
//  Todoey
//
//  Created by Chee Hung Chan on 21/1/2019.
//  Copyright © 2019年 Chee Hung Chan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Scott CR 1", "Pinarello F10", "Specialized S-Works SL6"]
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            //print(textField.text!)
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
        
        print(cell?.textLabel?.text)
    }

}

