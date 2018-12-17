//
//  ViewController.swift
//  Concentration
//
//  Created by Luke on 7/6/18.
//  Copyright © 2018 Luke Yuan. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairs: Int(cardButtons.count / 2))
    
    private var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    private var currentChoices: String!
    private var emoji = [Card:String]()
    private var emojiChoices: String!
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            currentChoices = emojiChoices
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, currentChoices.count > 0 {
            let randomIndex = currentChoices.index(currentChoices.startIndex, offsetBy: Int(arc4random_uniform(UInt32(currentChoices.count))))
            emoji[card] = String(currentChoices.remove(at: randomIndex))
        }
        
        return emoji[card] ?? "?"
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func newGame() {
        game = Concentration(numberOfPairs: Int(cardButtons.count / 2))
        theme = "🖥⌚️📺📞💽💾⌨️💻"
        updateViewFromModel()
        
    }
    
    private func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
            }
        score = game.score
        }
    }
    
    override func viewDidLoad() {
        newGame()
    }
    
}

