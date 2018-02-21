//
//  CategoryTableViewController.swift
//  WillDo
//
//  Created by Thao Doan on 2/16/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    
    let realm =  try! Realm()
    
    var categories : Results<Category>?
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
//        let nib = UINib(nibName: "categoryCell", bundle: nil)
//        self.tableView.register(nib, forCellReuseIdentifier:"categoryCell")
        loadCategory()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
         cell.textLabel?.text  = categories?[indexPath.row].name ?? "No category Added"
        
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
    
 
    
    


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category  ", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // what will happen once users clicks Add Itme on UIAlert
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
            
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
            
            try realm.write {
                realm.add(category)
            }
            
        } catch {
            
            print("Error saving context\(error)")
        }
        
        tableView.reloadData()
    }

    func loadCategory(){
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
}
