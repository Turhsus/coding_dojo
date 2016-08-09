//
//  ViewController.swift
//  tipster
//
//  Created by Sushrut Athavale on 7/12/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var moneyLabel: UILabel!
  @IBOutlet weak var fivePLabel: UILabel!
  @IBOutlet weak var tenPLabel: UILabel!
  @IBOutlet weak var fifteenPLabel: UILabel!
  @IBOutlet weak var tip5: UILabel!
  @IBOutlet weak var tip10: UILabel!
  @IBOutlet weak var tip15: UILabel!
  @IBOutlet weak var total5: UILabel!
  @IBOutlet weak var total10: UILabel!
  @IBOutlet weak var total15: UILabel!
  @IBOutlet weak var groupSizeLabel: UILabel!
  
  var money = "0";
  var tipPercent: Int = 5;
  var groupSize: Int = 1;
  
  @IBAction func button9(sender: UIButton) {
    loadMoney("9")
    loadAllTips()
  }
  @IBAction func button8(sender: UIButton) {
    loadMoney("8")
    loadAllTips()
  }
  @IBAction func button7(sender: UIButton) {
    loadMoney("7")
    loadAllTips()
  }
  @IBAction func button6(sender: UIButton) {
    loadMoney("6")
    loadAllTips()
  }
  @IBAction func button5(sender: UIButton) {
    loadMoney("5")
    loadAllTips()
  }
  @IBAction func button4(sender: UIButton) {
    loadMoney("4")
    loadAllTips()
  }
  @IBAction func button3(sender: UIButton) {
    loadMoney("3")
    loadAllTips()
  }
  @IBAction func button2(sender: UIButton) {
    loadMoney("2")
    loadAllTips()
  }
  @IBAction func button1(sender: UIButton) {
    loadMoney("1")
    loadAllTips()
  }
  @IBAction func button0(sender: UIButton) {
    loadMoney("0")
    loadAllTips()
  }
  @IBAction func buttonDecimal(sender: UIButton) {
    loadMoney(".")
    loadAllTips()
  }
  @IBAction func buttonC(sender: UIButton) {
    money = "0"
    moneyLabel.text = money
    loadAllTips()
  }
  @IBOutlet weak var tipPercentSlider: UISlider!
  @IBOutlet weak var groupSizeSlider: UISlider!
  
  @IBAction func tipPercentSliderChanged(sender: UISlider) {
    tipPercent = Int(sender.value)
    loadAllTips()
  }
  
  @IBAction func groupSizeSliderChanged(sender: UISlider) {
    groupSize = Int(sender.value)
    groupSizeLabel.text = "Group Size: \(groupSize)d"
    loadAllTips()
  }
  
  func loadMoney(number: String){
    if (money == "0"){
      money = number
    }
    else {
      money += number
    }
    moneyLabel.text = money
  }
  
  func loadAllTips(){
    fivePLabel.text = String(tipPercent) + "%"
    tenPLabel.text = String(tipPercent + 5) + "%"
    fifteenPLabel.text = String(tipPercent + 10) + "%"
    let tp: Double = Double(tipPercent)/100.0
    print(tipPercent)
    print(tp + 1.0)
    print((Double(tp) * Double(money)!))
    tip5.text = String((Double(tp) * Double(money)!)/Double(groupSize))
    tip10.text = String(((Double(tp) + 0.05) * Double(money)!)/Double(groupSize))
    tip15.text = String(((Double(tp) + 0.10) * Double(money)!)/Double(groupSize))
    total5.text = String(Double(money)! + Double(tip5.text!)!)
    total10.text = String(Double(money)! + Double(tip10.text!)!)
    total15.text = String(Double(money)! + Double(tip15.text!)!)
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    moneyLabel.text = "0"
    loadAllTips()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

