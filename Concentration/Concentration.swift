//
//  Concentration.swift
//  Concentration
//
//  Created by Luke on 7/8/18.
//  Copyright © 2018 Luke Yuan. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var score = 0
    
    private var indexOfOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpCardIndices.count == 1 ? faceUpCardIndices[0] : nil
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private(set) var cards = [Card]()
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index { // if a card is already flipped
                if cards[matchIndex] == cards[index] { // if cards match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else { // if cards don't match
                    if cards[matchIndex].flipped {
                        score -= 1
                    } else {
                        cards[matchIndex].flipped = true
                    }
                    if cards[index].flipped {
                        score -= 1
                    } else {
                        cards[index].flipped = true
                    }
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOnlyFaceUpCard = index
            }

        }
    }
    
    init(numberOfPairs: Int) {
        for _ in 1...numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
        
        for index in cards.indices {
            let randIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let temp = cards[index]
            cards[index] = cards[randIndex]
            cards[randIndex] = temp
        }
    }
}
