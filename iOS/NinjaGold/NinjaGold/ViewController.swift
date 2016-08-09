//
//  ViewController.swift
//  NinjaGold
//
//  Created by Sushrut Athavale on 7/6/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var farmLabel: UILabel!
  @IBOutlet weak var caveLabel: UILabel!
  @IBOutlet weak var houseLabel: UILabel!
  @IBOutlet weak var casinoLabel: UILabel!
  
  var score = 0
  
  @IBAction func farmButtonPress(sender: UIButton) {
    hideAllGolds()
    let gold = Int(arc4random_uniform(10) + 10)
    score += gold
    farmLabel.text = "You earned \(gold) gold!"
    farmLabel.hidden = false
    scoreLabel.text = "Score: \(score)"
  }
  
  @IBAction func caveButtonPress(sender: UIButton) {
    hideAllGolds()
    let gold = Int(arc4random_uniform(5) + 5)
    score += gold
    caveLabel.text = "You earned \(gold) gold!"
    caveLabel.hidden = false
    scoreLabel.text = "Score: \(score)"
  }
  
  @IBAction func houseButtonPress(sender: UIButton) {
    hideAllGolds()
    var gold = Int(arc4random_uniform(5))
    if gold <= 1 {
      gold = 2
    }
    score += gold
    houseLabel.text = "You earned \(gold) gold!"
    houseLabel.hidden = false
    scoreLabel.text = "Score: \(score)"
  }
  
  @IBAction func casinoButtonPress(sender: UIButton) {
    hideAllGolds()
    let winOrNot = Int(arc4random_uniform(2))
    if winOrNot == 0 {
      let gold = Int(arc4random_uniform(50))
      score += gold
      casinoLabel.text = "You earned \(gold) gold!"
    }
    else if winOrNot == 1 {
      let gold = Int(arc4random_uniform(50))
      print("negative")
      score -= gold
      casinoLabel.text = "You lost \(gold) gold!"
    }
    casinoLabel.hidden = false
    scoreLabel.text = "Score: \(score)"
  }
  
  @IBAction func resetButtonPress(sender: UIButton) {
    hideAllGolds()
    score = 0
    scoreLabel.text = "Score: \(score)"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    afterLoadViewHelper()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func afterLoadViewHelper() {
    scoreLabel.text = "Score: \(score)"
    hideAllGolds()
  }
  
  func hideAllGolds() {
    farmLabel.hidden = true
    caveLabel.hidden = true
    houseLabel.hidden = true
    casinoLabel.hidden = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

