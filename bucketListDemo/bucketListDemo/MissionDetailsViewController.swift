//
//  MissionDetailsViewController.swift
//  bucketListDemo
//
//  Created by Pariece Mckinney on 7/14/16.
//  Copyright © 2016 pariece. All rights reserved.
//

import UIKit

class MissionDetailsViewController: UIViewController {
    var cancelDelegate: CancelDelegate?
    var doneDelegate: DoneDelegate?
    var missionToEdit: Mission?
    var indexOfMissionToEdit: Int?
    
    @IBOutlet weak var userTextField: UITextField!
    
    
    @IBAction func donePressed(sender: AnyObject) {
        
        let text = userTextField.text!
        
        if missionToEdit != nil {
            doneDelegate?.didFinishEditingMission(self, mission: missionToEdit!)
        }else{
            doneDelegate?.didFinishAddingMission(self, newMission: text)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mission = missionToEdit {
            userTextField.text = mission.details
        }
        
    }
    
    
    @IBAction func cancelPressed(sender: AnyObject) {
        cancelDelegate?.cancelButtonPressed(self)
    }
    
}
