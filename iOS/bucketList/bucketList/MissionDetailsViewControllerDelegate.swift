//
//  MissionDetailsViewControllerDelegate.swift
//  bucketList
//
//  Created by Sushrut Athavale on 7/14/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import Foundation
import UIKit
protocol MissionDetailsViewControllerDelegate: class {
  func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String)
  func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: String, atIndexPath indexPath: Int)
}