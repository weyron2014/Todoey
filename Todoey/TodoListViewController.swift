//
//  ViewController.swift
//  Todoey
//
//  Created by мак on 14.01.19.
//  Copyright © 2019 мак. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var tasks = ["Cook", "Homework", "Gym"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let task = defaults.array(forKey: "TodoeyListArray") as? [String] {
            tasks = task
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tasks[indexPath.row])
        if(tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButton(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (alertAction) in
            self.tasks.append(textField.text!)
            self.defaults.set(self.tasks, forKey: "TodoeyListArray") //save our data to defaults
            self.tableView.reloadData()//reload the table to see changes
            
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Write a new todoey"
             textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

