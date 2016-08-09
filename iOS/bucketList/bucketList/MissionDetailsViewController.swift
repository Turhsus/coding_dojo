//
//  MissionDetailsViewController.swift
//  bucketList
//
//  Created by Sushrut Athavale on 7/14/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import Foundation
import UIKit

class MissionDetailsViewController: UITableViewController {
  weak var cancelButtonDelegate: CancelButtonDelegate?
  weak var delegate: MissionDetailsViewControllerDelegate?
  var missionToEdit: String?
  var missionToEditIndexPath: Int?
  
  @IBOutlet weak var newMissionTextField: UITextField!
  
  @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
    cancelButtonDelegate?.cancelButtonPressedFrom(self)
  }
  
  @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
    if var mission = missionToEdit {
      mission = newMissionTextField.text!
      delegate?.missionDetailsViewController(self, didFinishEditingMission: mission, atIndexPath: missionToEditIndexPath!)
    } else { // we are adding so run the "didFinishAddingMission" method
      let mission = newMissionTextField.text!
      delegate?.missionDetailsViewController(self, didFinishAddingMission: mission)
    }
  }
  
  
  
}