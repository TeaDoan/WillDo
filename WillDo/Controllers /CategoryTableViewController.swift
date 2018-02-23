//
//  CategoryTableViewController.swift
//  WillDo
//
//  Created by Thao Doan on 2/16/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework 


class CategoryTableViewController: UITableViewController {
    
    // initialize a new acess point to realm database
    let realm =  try! Realm()
    
    // a colection of results that is category objects
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        // load up catagory data when first load the app
        
        loadCategory()
        
    }
    
    // Mark: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        if let category = categories?[indexPath.row]
        {
            cell.backgroundColor = UIColor(hexString: category.colour )
            
            cell.textLabel?.text  = category.name
            
            cell.textLabel?.textColor = ContrastColorOf((UIColor(hexString: category.colour ))!, returnFlat: true)
        
        } else {
            
            cell.textLabel?.text = "No category added "
            
            cell.backgroundColor = UIColor.blue
            
            cell.textLabel?.textColor = UIColor.white 
        
        }
        
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! WiDoTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete){
            let categorySelected = categories?[indexPath.row]
            try! self.realm.write({
                self.realm.delete(categorySelected!)
            })
            
            tableView.deleteRows(at:[indexPath], with: .automatic)
            
        }
         tableView.reloadData()
    }
    


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category  ", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // what will happen once users clicks Add Itme on UIAlert
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat.hexValue()
           
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (Field) in
            
            Field.placeholder = "Creat new category"
            
            textField = Field
            
        }
        
         alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func save(category: Category) {
        
        do {
            // use realm.write to commit changes in the database
            try realm.write {
            //with is add a new categhory to realm
                realm.add(category)
            }
            
        } catch {
            
            print("Error saving context\(error)")
        }
        
        tableView.reloadData()
    }

    func loadCategory(){
        // set cagegories to look inside realm and fetch all the objects that belong to category data type
        
        categories = realm.objects(Category.self)
        // then reload user interface with new data
        tableView.reloadData()
    }
    
}
