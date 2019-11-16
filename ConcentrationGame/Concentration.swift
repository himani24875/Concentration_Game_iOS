//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by Himani on 14/11/19.
//  Copyright © 2019 Himani. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
//    var theme: Theme?
    var themes = [Theme]()
    var score = 0
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        setThemes()
        shuffleCards()
    }
    
    func shuffleCards() {
        var shuffled = [Card]()
        
        for _ in 0..<cards.count {
            let randomNo = Int(arc4random_uniform(UInt32(cards.count - 1)))
            shuffled.append(cards.remove(at: randomNo))
        }
        cards = shuffled
    }
    
    func chooseCard(at index: Int) {
        
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                if cards[matchedIndex].identifier == cards[index].identifier {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].isFlipped && cards[matchedIndex].isFlipped {
                        score += -2
                    } else if cards[index].isFlipped || cards[matchedIndex].isFlipped {
                        score += -1
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }  else {
                for flipDownIndex in cards.indices {
                    if cards[flipDownIndex].isFaceUp {
                        cards[flipDownIndex].isFaceUp = false
                        cards[flipDownIndex].isFlipped = true
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func setThemes() {
        let animalTheme = Theme(themeName: "animals", themeEmojis: ["🐼", "🐔", "🦄", "🐧" , "🦛", "🦞"])
        let sportsTheme = Theme(themeName: "sports", themeEmojis: ["🏀", "🏈", "⚾", "🏑", "🏏", "⛷"])
        let facesTheme = Theme(themeName: "faces", themeEmojis: ["😀", "🤩", "😢", "🥺",  "🤓", "😉"])
        
        let vehiclesTheme = Theme(themeName: "vehicles", themeEmojis: ["🚗", "🚙", "✈️", "🚤", "🚝", "🚂"])
        let halloweenTheme = Theme(themeName: "halloween", themeEmojis: ["🏴‍☠️", "🎃", "👹", "👿", "🕷", "🦐"])
        let foodTheme = Theme(themeName: "food", themeEmojis: ["🧀", "🌯", "🍕", "🍉", "🍰", "🍎"])
        
        themes = [animalTheme, sportsTheme, facesTheme, halloweenTheme, vehiclesTheme, foodTheme]
    }
    
    func selectTheme() -> Theme {
        let randomNo = Int(arc4random_uniform(UInt32(themes.count - 1)))
        return themes[randomNo]
    }
}

