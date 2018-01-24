//
//  Concentration.swift
//  Concentration
//
//  Created by Rasesh Ramanuj on 21/01/2018.
//  Copyright © 2018 Rasesh R. Ramanuj. All rights reserved.
//

import Foundation
struct Concentration
{
    //swift assumes vars are writable.
 /*  private var indexOfOneAndOnlyFaceUpCard: Int?{
        get {
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    } //good use of optional, match is either matched or not.*/
    
    //simplifiying indexOfOneAndOnlyFaceUpCard functions
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
            //return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
    } //good use of optional, match is either matched or not.*/
    
    
    private(set) var cards = [Card]()
   //fundamental public API
   mutating func chooseCard(at index: Int) //not marked mutable, assumed not to mutable
    {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex] == cards[index] { //because equatable due to the struct hashable!
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else {
               /* //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true*/
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards): You must have atleast one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
            //cards.append(card)
            //cards.append(card)
        }
    }
    // TODO: Shuffle the cards
}
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
