//
//  PeopleTableViewController.swift
//  core_data_lecture
//
//  Created by Pariece Mckinney on 7/18/16.
//  Copyright © 2016 pariece. All rights reserved.
//

import UIKit
import CoreData

class PeopleTableViewController: UITableViewController {
    var people = [People]()
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUsers()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("peopleCell")!
        cell.textLabel?.text = people[indexPath.row].name!
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let person = people[indexPath.row]
        context.deleteObject(person)
        
        do{
            try context.save()
            updateUsers()
            tableView.reloadData()
        }catch let error as NSError {
            print(error)
        }
    }
    
    func updateUsers(){
        
        let fetch = NSFetchRequest(entityName: "People")
        
        
        do {
            let results = try context.executeFetchRequest(fetch)
            people = results as! [People]
            
            
            
        }catch let error as NSError{
            print(error)
        }
        
        
        
        
        
    }
    
    
}
