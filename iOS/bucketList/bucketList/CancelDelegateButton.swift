//
//  CancelDelegateButton.swift
//  bucketList
//
//  Created by Sushrut Athavale on 7/14/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import Foundation
import UIKit
protocol CancelButtonDelegate: class {
  func cancelButtonPressedFrom(controller: UIViewController)
}