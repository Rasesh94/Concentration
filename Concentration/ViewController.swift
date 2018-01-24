//
//  ViewController.swift
//  Concentration
//
//  Created by Rasesh Ramanuj on 21/01/2018.
//  Copyright © 2018 Rasesh R. Ramanuj. All rights reserved.
//

import UIKit //includes UIKit, which is the iOS frameworks -- buttons,frameworks etc.

class ViewController: UIViewController
{    //UIViewController is the superclass.
    //this class knows everything about the UI.
    private lazy var game = Concentration(numberOfPairsOfCards:numberOfPairsOfCards)
    //lazy's can't have a didset. But a lazy is cool because it waits for the data being passed to the be processed prior to running.
    
    
    var numberOfPairsOfCards: Int {
        return ((cardButtons.count + 1) / 2)
    }
    
    private(set) var flipCount = 0 { //i dont mind people getting it, but no set.
        //initalizing doesn't initiate the didset.
        didSet{ //property ovserver
            updateFlipCountLabel()
            }
        }
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        ]
        let attributesString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
            flipCountLabel.attributedText = attributesString
    }

    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{ //property ovserver
            updateFlipCountLabel()
        }
    }
    //didset gets called when the connection is made


    @IBOutlet private var cardButtons: [UIButton]!
  //  private var emojiChoices = ["👻","💩","🙈","🐴",]
    private var emojiChoices = "👻💩🙈🐴"
    @IBAction private func touchCard(_ sender: UIButton)
    {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            print("cardNumber = \(cardNumber)")
        } else {
            print("chosen card wasn't here")
        }
    }
   private func  updateViewFromModel(){
        for index in cardButtons.indices {
            //indices is a method that returns a countable range of all the index's in the array.
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                
            }
        }
    }
    private var emoji = [Card:String]()
    //making a card
    private func  emoji(for card: Card) -> String{
        if emoji[card] == nil {
         // let x = 5.arc4random
            if emojiChoices.count > 0 {
                let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
                emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            }
        }
        //this line replaces the commented code below
     /*   if emoji[card.identifier] != nil {
            return emoji[card.identifier]!
        } else {
        return "?"*/
        return emoji[card] ?? "?"
        }
}
extension Int {
        var arc4random: Int {
            if self > 0 {
                return Int(arc4random_uniform(UInt32(self)))
            } else if self < 0 {
                return -Int(arc4random_uniform(UInt32(self)))
            }else {
                return 0
            }
        }
    }


    //it should read like english
    //in swift there are 2 names, internal names and external names
   /* func flipCard(withEmoji emoji: String, on button: UIButton){
     //   print("flipCard(withEmoji: \(emoji)")
        if button.currentTitle == emoji{
 
        }
        else{
 
        }*/
    //}


