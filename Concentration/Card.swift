//
//  Card.swift
//  Concentration
//
//  Created by Rasesh Ramanuj on 21/01/2018.
//  Copyright © 2018 Rasesh R. Ramanuj. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    //initializer.
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
    //TODO: Shuffle the cards
}
