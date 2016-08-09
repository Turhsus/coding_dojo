//
//  DoneDelegate.swift
//  bucketListDemo
//
//  Created by Pariece Mckinney on 7/14/16.
//  Copyright © 2016 pariece. All rights reserved.
//

import UIKit

@objc protocol DoneDelegate: class {
    func didFinishAddingMission(controller: UIViewController,newMission: String)
    
    func didFinishEditingMission(controller: UIViewController,mission: Mission)
    
    optional func testFunction(controller: UIViewController)
    
}
