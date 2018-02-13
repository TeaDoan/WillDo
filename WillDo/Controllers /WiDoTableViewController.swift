//
//  ViewController.swift
//  WillDo
//
//  Created by Thao Doan on 2/10/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class WiDoTableViewController: UITableViewController {
    
    var itemsArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        let newItem = Item()
        newItem.tittle = "find money"
        itemsArray.append(newItem)
        
        let newItem1 = Item()
        newItem.tittle = "find tea"
        itemsArray.append(newItem1)
        
        loadItems()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text  = itemsArray[indexPath.row].tittle
        
        let item = itemsArray[indexPath.row]
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    //Mark: Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    }
    // Add new  items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Wido Items ", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once users clicks Add Itme on UIAlert
            
            let newItem = Item()
            
            newItem.tittle = textField.text!
            
            self.itemsArray.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Creat new items"
            
            textField = alertTextField
           
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            
            let data = try encoder.encode(itemsArray)
            
            try data.write(to: dataFilePath!)
            
        } catch {
            
            print ("Error ecoding item array,\(error)")
        }
        
        self.tableView.reloadData()
        
        
    }
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            
            let decoder = PropertyListDecoder()
            do {
                
                itemsArray = try decoder.decode([Item].self, from: data)
            }  catch {
                
                print ("\(error)")
            }
            


        }
    }
}
    

