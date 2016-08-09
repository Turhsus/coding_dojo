//: Playground - noun: a place where people can play

import UIKit

var arrOfInts = [Int]()

for i in 1...255{
  arrOfInts.append(i)
}

for i in 1...100{
  var index1 = Int(arc4random_uniform(255))
  var index2 = Int(arc4random_uniform(255))
  var temp = arrOfInts[index1]
  arrOfInts[index1] = arrOfInts[index2]
  arrOfInts[index2] = temp
}

var popIndex = 0

for i in 0..<arrOfInts.count{
  if arrOfInts[i] == 42 {
    print("We found the answer to the Ultimate Question of Life, the Universe, and Everything at index \(i)")
    popIndex = i
  }
}
arrOfInts.removeAtIndex(popIndex)
