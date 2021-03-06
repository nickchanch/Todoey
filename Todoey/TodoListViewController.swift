//
//  ViewController.swift
//  Todoey
//
//  Created by Chee Hung Chan on 21/1/2019.
//  Copyright © 2019年 Chee Hung Chan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    //var itemArray = ["Scott CR 1", "Pinarello F10", "Specialized S-Works SL6"]
    var itemArray = [ListItem]()
    // Set data file path
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Todoey.plist")
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            //print(textField.text!)
            let newItem = ListItem()
            newItem.desc = textField.text!
            self.itemArray.append(newItem)
            self.saveData()
            //self.defaults.set(self.itemArray, forKey: "ToDoList")
            self.tableView.reloadData()
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
        let item1 = ListItem()
        item1.desc = "Scott CR1"
        itemArray.append(item1)
        
        let item2 = ListItem()
        item2.desc = "Pinarello F10"
        itemArray.append(item2)
        
        let item3 = ListItem()
        item3.desc = "S-Works SL6"
        itemArray.append(item3)
        
//        if let items = defaults.array(forKey: "ToDoList") as? [ListItem] {
//            itemArray = items
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func saveData() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding array \(error)")
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([ListItem].self, from: data)
            } catch {
                print("Error decoding: \(error)")
            }
            
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //cell.textLabel?.text = itemArray[indexPath.row]
        cell.textLabel?.text = itemArray[indexPath.row].desc
        cell.accessoryType = itemArray[indexPath.row].checked ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        saveData()
        tableView.reloadData()
        
//        if cell?.accessoryType == .checkmark {
//            cell?.accessoryType = .none
//        } else {
//            cell?.accessoryType = .checkmark
//        }
        
    }

}

