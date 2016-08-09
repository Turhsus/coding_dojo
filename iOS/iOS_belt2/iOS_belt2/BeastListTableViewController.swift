//
//  ViewController.swift
//  iOS_belt2
//
//  Created by Sushrut Athavale on 7/22/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import UIKit
import CoreData

class BeastListTableViewController: UITableViewController, cancelDelegate, doneDelegate {
    var beasts = [Beast]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        fetchAllBeasts()
        super.viewDidLoad()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beasts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("beastCell")!
        cell.textLabel?.text = beasts[indexPath.row].details
//        cell.accessoryType = .DetailDisclosureButton
        return cell
    }
    
//    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
//        let calendar = NSCalendar.currentCalendar()
//        let date = NSDate()
//        _ = calendar.components([.Month, .Day], fromDate: date)
//
//        beasts[indexPath.row].timeBeasted = NSDate()
//        fetchAllBeasts()
//        tableView.reloadData()
//        print(indexPath.row)
//    }
    
    @IBAction func beastedButtonPressed(sender: UIButton) {
        let buttonTag = sender.tag
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate()
        _ = calendar.components([.Month, .Day], fromDate: date)
        beasts[buttonTag].timeBeasted = NSDate()
        print(buttonTag)
        print("beast pressed!")
    }
    
    func fetchAllBeasts () {
        let userRequest = NSFetchRequest(entityName: "Beast")
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            beasts = results as! [Beast]
        } catch {
            print("\(error)")
        }
        for (index, beast) in beasts.enumerate() {
            if beast.timeBeasted != nil {
                beasts.removeAtIndex(index)
            }
        }
    }

    func cancelButtonPressed(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didFinishAddingBeast(controller: UIViewController, beast: String) {
        let newBeast = NSEntityDescription.insertNewObjectForEntityForName("Beast", inManagedObjectContext: managedObjectContext) as! Beast
        newBeast.details = beast
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        fetchAllBeasts()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didFinishEditingBeast(controller: UIViewController, beast: Beast) {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        fetchAllBeasts()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        managedObjectContext.deleteObject(beasts[indexPath.row])
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        fetchAllBeasts()
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addBeast" {
            let navController = segue.destinationViewController as! UINavigationController
            let beastController = navController.topViewController as! BeastDetailsViewController
            
            beastController.CancelDelegate = self
            beastController.DoneDelegate = self
        }
        else if segue.identifier == "editBeast" {
            let navController = segue.destinationViewController as! UINavigationController
            let beastController = navController.topViewController as! BeastDetailsViewController
            
            beastController.CancelDelegate = self
            beastController.DoneDelegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell){
                beastController.beastToEdit = beasts[indexPath.row]
                beastController.indexOfBeastToEdit = indexPath.row
            }
        }
    }
}

