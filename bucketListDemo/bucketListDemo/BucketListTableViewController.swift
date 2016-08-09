//
//  ViewController.swift
//  bucketListDemo
//
//  Created by Pariece Mckinney on 7/14/16.
//  Copyright © 2016 pariece. All rights reserved.
//

import UIKit
import CoreData

class BucketListTableViewController: UITableViewController, CancelDelegate, DoneDelegate {
    var list = [Mission]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
  
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view, typically from a nib.
        fetchAllMissions()
        super.viewDidLoad()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("missionCell")!
        cell.textLabel?.text = list[indexPath.row].details
        return cell
    }
    
    func cancelButtonPressed(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func fetchAllMissions(){
        let userRequest = NSFetchRequest(entityName: "Mission")
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            list = results as! [Mission]
        } catch {
            print("\(error)")
        }
    }
    
    func didFinishAddingMission(controller:UIViewController,newMission:String){
        let mission = NSEntityDescription.insertNewObjectForEntityForName("Mission", inManagedObjectContext: managedObjectContext) as! Mission
        mission.details = newMission
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        fetchAllMissions()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didFinishEditingMission(controller: UIViewController, mission: Mission) {
        let editMission = NSEntityDescription.insertNewObjectForEntityForName("Mission", inManagedObjectContext: managedObjectContext) as! Mission
        print("\(mission.details)")
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }

        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        list.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addMission" {
            let navController = segue.destinationViewController as! UINavigationController
            let missionController = navController.topViewController as! MissionDetailsViewController
            
            missionController.cancelDelegate = self
            missionController.doneDelegate = self
        }else {
            let navController = segue.destinationViewController as! UINavigationController
            let missionController = navController.topViewController as! MissionDetailsViewController
            
            missionController.cancelDelegate = self
            missionController.doneDelegate = self
            
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell){
//                missionController.missionToEdit = list[indexPath.row]
                missionController.indexOfMissionToEdit = indexPath.row
            }
            
        }
    }

}

