//
//  Card.swift
//  ConcentrationGame
//
//  Created by Himani on 14/11/19.
//  Copyright © 2019 Himani. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    let identifier: Int
    var isFlipped = false
    
    static var identifierFactory = 0
    
    init() {
        identifier = Card.generateUniqueId()
    }
    
    static func generateUniqueId() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}
