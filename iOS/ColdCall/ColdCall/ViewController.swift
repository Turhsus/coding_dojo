//
//  ViewController.swift
//  ColdCall
//
//  Created by Sushrut Athavale on 7/6/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var names = ["Adam", "Calvin", "Nicole", "JD", "Soumya"]

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var numberLabel: UILabel!
  
  @IBAction func callButtonPress(sender: UIButton) {
    generateName()
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    numberLabel.hidden = true
    nameLabel.text = "Ready?"
    nameLabel.font = nameLabel.font.fontWithSize(50)
    numberLabel.font = numberLabel.font.fontWithSize(150)
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func generateName() {
    let index = Int(arc4random_uniform(5))
    nameLabel.text = names[index]
    numberLabel.text = String(index + 1)
    if index < 2 {
      numberLabel.textColor = UIColor.redColor()
    }
    else if index < 4 {
      numberLabel.textColor = UIColor.orangeColor()
    }
    else {
      numberLabel.textColor = UIColor.greenColor()
    }
    numberLabel.hidden = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

