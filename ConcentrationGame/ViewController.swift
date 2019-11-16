//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Himani on 14/11/19.
//  Copyright © 2019 Himani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    lazy var emojiChoice = game.selectTheme().themeEmojis
        
    @IBOutlet weak var gameTheme: UILabel!
    
    @IBAction func playNewGame(_ sender: UIButton) {
        emojiChoice = game.selectTheme().themeEmojis
        game.score = 0
        gameTheme.text = "Your Score: \(game.score)"
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            gameTheme.text = "Your Score: \(game.score)"
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button =  cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoice.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoice.count - 1)))
            emoji[card.identifier] = emojiChoice.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

