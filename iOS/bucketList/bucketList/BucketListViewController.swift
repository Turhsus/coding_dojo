//
//  ViewController.swift
//  bucketList
//
//  Created by Sushrut Athavale on 7/13/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, CancelButtonDelegate, MissionDetailsViewControllerDelegate {
  var missions = ["Sky diving", "Live in Hawaii"]
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  func cancelButtonPressedFrom(controller: UIViewController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String) {
    print(mission)
    dismissViewControllerAnimated(true, completion: nil)
    missions.append(mission)
    tableView.reloadData()
  }
  
  func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: String, atIndexPath indexPath: Int) {
    dismissViewControllerAnimated(true, completion: nil)
    missions[indexPath] = mission
    tableView.reloadData()
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // dequeue the cell from our storyboard
    let cell = tableView.dequeueReusableCellWithIdentifier("MyCell")!
    // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
    cell.textLabel?.text = missions[indexPath.row]
    // return cell so that Table View knows what to draw in each row
    return cell
  }
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return missions.count
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    missions.removeAtIndex(indexPath.row)
    tableView.reloadData()
  }
    
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "addNewMission" {
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller  = navigationController.topViewController as! MissionDetailsViewController
      controller.cancelButtonDelegate = self
      controller.delegate = self
    }
    else {
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! MissionDetailsViewController
      controller.cancelButtonDelegate = self
      controller.delegate = self
      // Here we set the missionToEdit so that we can have the mission text on the MissionDetailsViewController
      if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
        controller.missionToEdit = missions[indexPath.row]
        controller.missionToEditIndexPath = indexPath.row
      }
    }
  }

}

