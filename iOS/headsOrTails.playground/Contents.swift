//: Playground - noun: a place where people can play

import UIKit

func tossCoin() -> String {
  print("Flipping a coin!")
  let ranNum = arc4random_uniform(2)
  var result: String?
  if ranNum == 0 {
    result = "Heads"
  }
  else if ranNum == 1 {
    result = "Tails"
  }
  print(result)
  return result!
}

func tossMultipleCoins(times: Int) -> Double {
  var heads = 0.0
  var tails = 0.0
  for i in 1...times{
    let result = tossCoin()
    if result == "Heads"{
      heads += 1
    }
    else if result == "Tails"{
      tails += 1
    }
  }
  let ratio = heads/Double(times)
  return ratio
}

tossMultipleCoins(3)