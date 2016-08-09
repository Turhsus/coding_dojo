//
//  doneDelegate.swift
//  iOS_belt2
//
//  Created by Sushrut Athavale on 7/22/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import UIKit

protocol doneDelegate: class {
    func didFinishAddingBeast(controller: UIViewController, beast: String)
    func didFinishEditingBeast(controller: UIViewController, beast: Beast)
}
