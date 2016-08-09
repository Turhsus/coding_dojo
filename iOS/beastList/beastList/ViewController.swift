//
//  ViewController.swift
//  beastList
//
//  Created by Sushrut Athavale on 7/13/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var tasks: [String] = []
  
  @IBOutlet weak var insertTaskField: UITextField!

  @IBOutlet weak var tableView: UITableView!
  
  @IBAction func insertButtonPressed(sender: UIButton) {
    if let taskItem = insertTaskField.text {
      tasks.append(taskItem)
    }
    insertTaskField.text = nil
    tableView.reloadData()
  }
  
 
  
  func tableView(sender: UITableView, numberOfRowsInSection: Int) -> Int {
    return tasks.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("MyCell")!
    cell.textLabel?.text = tasks[indexPath.row]
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("Section: \(indexPath.section) and Row: \(indexPath.row)")
    tasks.removeAtIndex(indexPath.row)
    tableView.reloadData()
  }
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

