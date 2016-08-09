//
//  BeastDetailsViewController.swift
//  iOS_belt2
//
//  Created by Sushrut Athavale on 7/22/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import UIKit

class BeastDetailsViewController : UIViewController {
    var CancelDelegate: cancelDelegate?
    var DoneDelegate: doneDelegate?
    var beastToEdit: Beast?
    var indexOfBeastToEdit: Int?
    @IBOutlet weak var addBeastLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let beast = beastToEdit {
            addBeastLabel.text = beast.details
        }
        
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        CancelDelegate?.cancelButtonPressed(self)
    }

    @IBAction func donePressed(sender: AnyObject) {
        let text = addBeastLabel.text!
        
        if beastToEdit != nil {
            beastToEdit?.details = text
            DoneDelegate?.didFinishEditingBeast(self, beast: beastToEdit!)
        }
        else{
            DoneDelegate?.didFinishAddingBeast(self, beast: text)
        }
        
    }
}
