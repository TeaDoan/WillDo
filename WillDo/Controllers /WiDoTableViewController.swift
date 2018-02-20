//
//  ViewController.swift
//  WillDo
//
//  Created by Thao Doan on 2/10/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import CoreData

class WiDoTableViewController: UITableViewController {
    
    var itemsArray = [Item]()
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // this constant goes into the AppDeltgate and grabs thr persistant container then grabs the reference to the context for that persistant container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
//
//       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//
        
        
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
        
        let alert = UIAlertController(title: "Add New Wido  ", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once users clicks Add Itme on UIAlert
            
            let newItem = Item(context: self.context)
            
            newItem.tittle = textField.text!
            
            newItem.done = false
            
            newItem.parentCategory = self.selectedCategory
            
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
    
        do {
            
         try context.save()
            
        } catch {
            
           print("Error saving context\(error)")
        }
        
        tableView.reloadData()
        
        
    }
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(),predicate: NSPredicate? = nil){
        
        let categoryPredicate = NSCompoundPredicate(format: "parentCategory.name MATCHES %@",selectedCategory!.name!)
        if let additonalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additonalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
       
        do {
            try itemsArray = context.fetch(request)
        } catch {
            
            print ("Error fetching data from context \(error)")
        }
        
          tableView.reloadData()
    }
    
    
}

extension WiDoTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "tittle CONTAINS [cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "tittle", ascending:true)]
        
        loadItems(with: request, predicate: predicate)
       
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
    

