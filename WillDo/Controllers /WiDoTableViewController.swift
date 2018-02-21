//
//  ViewController.swift
//  WillDo
//
//  Created by Thao Doan on 2/10/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import RealmSwift

class WiDoTableViewController: UITableViewController {
    
    var todoItems : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet{
            
              loadItems()
        }
    }
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // this constant goes into the AppDeltgate and grabs thr persistant container then grabs the reference to the context for that persistant container
  
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadItems()
        
        
//
//       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//
        
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "No item added"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ??  1
    }
    //Mark: Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let items = todoItems?[indexPath.row] {
            
            do  {
                
                try realm.write {
                
               items.done = !items.done
                
              }
                }
              catch {
                print ("Error saving items,\(error)")
            }
        }
              tableView.reloadData()

        
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    }
    // Add new  items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Wido  ", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action)  in
            
            if let currentCategory = self.selectedCategory {
                
                do
                    
                {  try self.realm.write
                    {
                    let newItem = Item()
                    newItem.title  = textField.text!
                    newItem.date = Date()
                    
                    currentCategory.items.append(newItem)
                    }
                    
                }
                catch {
                        print ("Error saving new item, \(error)")
                    }
                }
               self.tableView.reloadData()
            }
            

            alert.addTextField { (alertTextField) in

            alertTextField.placeholder = "Creat new items"

            textField = alertTextField

        }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    func loadItems(){

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

          tableView.reloadData()
    }

}





extension WiDoTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // updating todoItems and fitler base on title of text on search bar ,and sorted ascending order
        
        todoItems = todoItems?.filter("title CONTAINS[Cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0 {

            loadItems()

            DispatchQueue.main.async {

                searchBar.resignFirstResponder()
            }
        }
    }
}


