//: Playground - noun: a place where people can play

import UIKit

class Animal {
  var name: String
  var health = 100
  init(name: String){
    self.name = name
  }
  func displayHealth(){
    print("Animal health is \(health)")
  }
}

class Cat: Animal {
  func growl() {
    print("Rawr")
  }
  override init(name: String){
    super.init(name: name)
    self.health = 150
  }
  func run() {
    if !(health < 11) {
      print("Running!")
      health -= 10
    }
  }
}

class Lion: Cat {
  override func growl() {
    print("ROAR!!!! I am King of the Jungle")
  }
  override init(name: String){
    super.init(name: name)
    self.health = 200
  }
}

class Cheetah: Cat {
  override func run() {
    print("Running Fast")
    health -= 50
  }
  func sleep() {
    if health < 200{
      health += 50
    }
  }
}

var myCheetah = Cheetah(name: "Cheeting")

myCheetah.run()
myCheetah.run()
myCheetah.run()
myCheetah.run()
myCheetah.displayHealth()
myCheetah.sleep()
myCheetah.displayHealth()

var myLion = Lion(name: "Lyin'")

myLion.run()
myLion.run()
myLion.run()
myLion.growl()

