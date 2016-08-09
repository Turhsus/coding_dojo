//
//  ViewController.swift
//  TTT
//
//  Created by Sushrut Athavale on 7/6/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var winnerLabel: UILabel!
  @IBOutlet weak var ttt1: UIButton!
  @IBOutlet weak var ttt2: UIButton!
  @IBOutlet weak var ttt3: UIButton!
  @IBOutlet weak var ttt4: UIButton!
  @IBOutlet weak var ttt5: UIButton!
  @IBOutlet weak var ttt6: UIButton!
  @IBOutlet weak var ttt7: UIButton!
  @IBOutlet weak var ttt8: UIButton!
  @IBOutlet weak var ttt9: UIButton!
  
  var whoseTurn = 0;
  var colorArray = ["gray1", "gray2", "gray3", "gray4", "gray5", "gray6", "gray7", "gray8", "gray9"]
  
  @IBAction func ttt1(sender: UIButton) {
    takeTurn(sender, buttonNumber: 0)
    checkIfWon()
  }
  
  @IBAction func ttt2(sender: UIButton) {
    takeTurn(sender, buttonNumber: 1)
    checkIfWon()
  }
  
  @IBAction func ttt3(sender: UIButton) {
    takeTurn(sender, buttonNumber: 2)
    checkIfWon()
  }
  
  @IBAction func ttt4(sender: UIButton) {
    takeTurn(sender, buttonNumber: 3)
    checkIfWon()
  }
  
  @IBAction func ttt5(sender: UIButton) {
    takeTurn(sender, buttonNumber: 4)
    checkIfWon()
  }
  
  @IBAction func ttt6(sender: UIButton) {
    takeTurn(sender, buttonNumber: 5)
    checkIfWon()
  }
  
  @IBAction func ttt7(sender: UIButton) {
    takeTurn(sender, buttonNumber: 6)
    checkIfWon()
  }
  
  @IBAction func ttt8(sender: UIButton) {
    takeTurn(sender, buttonNumber: 7)
    checkIfWon()
  }
  
  @IBAction func ttt9(sender: UIButton) {
    takeTurn(sender, buttonNumber: 8)
    checkIfWon()
  }
  
  @IBAction func resetButton(sender: UIButton) {
    colorArray = ["gray1", "gray2", "gray3", "gray4", "gray5", "gray6", "gray7", "gray8", "gray9"]
    whoseTurn = 0
    ttt1.backgroundColor = UIColor.lightGrayColor()
    ttt2.backgroundColor = UIColor.lightGrayColor()
    ttt3.backgroundColor = UIColor.lightGrayColor()
    ttt4.backgroundColor = UIColor.lightGrayColor()
    ttt5.backgroundColor = UIColor.lightGrayColor()
    ttt6.backgroundColor = UIColor.lightGrayColor()
    ttt7.backgroundColor = UIColor.lightGrayColor()
    ttt8.backgroundColor = UIColor.lightGrayColor()
    ttt9.backgroundColor = UIColor.lightGrayColor()
    winnerLabel.hidden = true
  }
  
  func takeTurn(tile: UIButton, buttonNumber: Int) {
    if whoseTurn == 0 {
      tile.backgroundColor = UIColor.blueColor()
      colorArray[buttonNumber] = "Blue"
      whoseTurn = 1
    }
    else {
      tile.backgroundColor = UIColor.redColor()
      colorArray[buttonNumber] = "Red"
      whoseTurn = 0
    }
  }
  
  func checkIfWon() {
    if colorArray[0] == colorArray[1] && colorArray[1] == colorArray[2] {
      winnerLabel.text = "\(colorArray[0]) has won!"
      winnerLabel.hidden = false
    }
    else if colorArray[3] == colorArray[4] && colorArray[4] == colorArray[5] {
      winnerLabel.text = "\(colorArray[3]) has won!"
      winnerLabel.hidden = false
    }
    else if colorArray[6] == colorArray[7] && colorArray[7] == colorArray[8] {
      winnerLabel.text = "\(colorArray[6]) has won!"
      winnerLabel.hidden = false
    }
    else if colorArray[0] == colorArray[3] && colorArray[3] == colorArray[6] {
      winnerLabel.text = "\(colorArray[0]) has won!"
      winnerLabel.hidden = false
    }
    else if colorArray[1] == colorArray[4] && colorArray[4] == colorArray[7] {
      winnerLabel.text = "\(colorArray[1]) has won!"
      winnerLabel.hidden = false
    }
    else if colorArray[2] == colorArray[5] && colorArray[5] == colorArray[8] {
      winnerLabel.text = "\(colorArray[2]) has won!"
      winnerLabel.hidden = false
    }
    else if colorArray[0] == colorArray[4] && colorArray[4] == colorArray[8] {
      winnerLabel.text = "\(colorArray[0]) has won!"
      winnerLabel.hidden = false
    }
    else if colorArray[2] == colorArray[4] && colorArray[4] == colorArray[6] {
      winnerLabel.text = "\(colorArray[2]) has won!"
      winnerLabel.hidden = false
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    winnerLabel.hidden = true
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

