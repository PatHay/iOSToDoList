//
//  ListViewController.swift
//  ToDoList
//
//  Created by Patrick Hayes on 11/9/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items = [ToDoList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllTodoItems()
        //attached tableview data source on storyboard
//        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func submit(_ sender: UIStoryboardSegue){
//        if sender.source is AddItemViewController{
            let controller = sender.source as! AddItemViewController  //force cast
            let item = NSEntityDescription.insertNewObject(forEntityName: "ToDoList", into: context) as! ToDoList

            item.title = controller.titleField.text
            item.detail = controller.detailField.text
            item.date = controller.datePickerField.date
            item.completed = false
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MMM dd, YYYY"
//            let toDoListItem.date = dateFormatter.string(from: controller.datePickerField.date)
        
        
            saveContext()
        
            items.append(item)
            tableView.reloadData()
                
//                print("\(TableViewCell.title) is the title, \(TableViewCell.detail) is the detail and \(TableViewCell.date) is the date")

    
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    

    
    func fetchAllTodoItems() {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoList")
            self.items = try context.fetch(request) as! [ToDoList]
        } catch {
            print(error)
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
}

extension ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! TableViewCell
        
        let toDoItem = items[indexPath.row]
        cell.titleLabel.text = toDoItem.title
        cell.detailLabel.text = toDoItem.detail
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let dateString = dateFormatter.string(from: toDoItem.date as! Date)
        cell.dateLabel.text = dateString
        
        
        
        if toDoItem.completed {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        
        
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Selected")
        let to_do_item = self.items[indexPath.row]

        to_do_item.completed = !to_do_item.completed
        saveContext()

        let cell = tableView.cellForRow(at: indexPath)
        if to_do_item.completed {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        tableView.reloadData()
    }
}

