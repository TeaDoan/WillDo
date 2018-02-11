//
//  ViewController.swift
//  WillDo
//
//  Created by Thao Doan on 2/10/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class WiDoTableViewController: UITableViewController {
    
    var itemsArray = ["Buy milk","Get gas","Take out trash"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text  = itemsArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    //Mark: Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let rowSelected = itemsArray[indexPath.row]
    
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    }
    // Add new  items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Wido Items ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once users clicks Add Itme on UIAlert
            self.itemsArray.append(textField.text!)
            self.tableView.reloadData()
            
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new items"
            textField = alertTextField
            print(alertTextField.text)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}
