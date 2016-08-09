//: Playground - noun: a place where people can play

import UIKit

struct Card {
  var value: String
  var suit: String
  var numerical_value: Int
}

let ace_spades = Card(value: "A", suit: "Spades", numerical_value: 1)

class Deck {
  var suits = ["Clubs", "Diamonds", "Spades", "Hearts"]
  var cards = [Card]()
  init(){
    self.reset()
  }
  
  func deal() -> Card {
    let dealt = cards[0]
    cards.removeAtIndex(0)
    return dealt
  }
  
  func reset() {
    cards.removeAll()
    for suit in suits {
      for i in 1...13 {
        var val = String(i)
        if i == 1{
          val = "A"
        }
        else if i == 11 {
          val = "J"
        }
        else if i == 12 {
          val = "Q"
        }
        else if i == 13 {
          val = "K"
        }
        self.cards.append(Card(value: val, suit: suit, numerical_value: i))
      }
    }
  }
  
  func shuffle() {
    for _ in 1...100{
      let index1 = Int(arc4random_uniform(UInt32(cards.count)))
      let index2 = Int(arc4random_uniform(UInt32(cards.count)))
      let temp = cards[index1]
      cards[index1] = cards[index2]
      cards[index2] = temp
    }
  }
}

class player {
  var name = "Default Player"
  var hand = [Card]()
  init(name: String){
    self.name = name
  }
  
  func draw(myDeck: Deck) -> Card{
    let drawn = myDeck.deal()
    hand.append(drawn)
    return drawn
  }
  
  func discard(badCard: Card) -> Bool{
    var found = false
    var foundIndex = Int()
    for i in 0..<hand.count{
      if hand[i].value == badCard.value && hand[i].suit == badCard.suit {
        found = true
        foundIndex = i
      }
    }
    if found {
      hand.removeAtIndex(foundIndex)
      return found
    }
    else {
      return !found
    }
  }
}

var newDeck = Deck()

newDeck.deal()
newDeck.shuffle()
newDeck.deal()
newDeck.reset()
newDeck.deal()