//
//  ViewController.swift
//  Concentration
//
//  Created by Mac on 6/27/20.
//  Copyright © 2020 Riyad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let theme1 = ["🥵","🥶","😱","🥱","🤢","🤡","👺","😈"]
    let theme2 = ["👘","🥻","🧣","🧤","👑","⛑","💼","👝"]
    let theme3 = ["🐶","🐥","🙉","🐹","🐸","🦁","🐦","🐝"]
    let theme4 = ["🍏","🍅","🥖","🥥","🍗","🍕","🌭","🍔"]
    let theme5 = ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉"]
    let theme6 = ["🚗","🚆","🚝","🚨","🛩","🚀","🛵","🚲"]
    var themes = Array<[String]>()
    lazy var game = ConcentrationModel(numberOfPairsOfCards: (cardButtons.count+1) / 2)
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0 {didSet{scoreLabel.text = "Score: \(score)"}}
    var flipCount = 0 {didSet{flipCountLabel.text = "Flips: \(flipCount)"}}
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func newGameButton(_ sender: Any) {
        flipCount = 0
        for index in cardButtons.indices{
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            game.cards[index].isInvolvedInMismatch = false
            emoji[game.cards[index].identifier] = nil
        }
        game.cards.shuffle()
        game.gameScore = 0
        game.GameFlipcount = 0
        emojiChoices = themes.randomElement()!
        updateViewFromModel()
    }
    @IBAction func touchCard(_ sender: UIButton) {
        if emojiChoices == nil{
            themes.append(theme1);themes.append(theme2);themes.append(theme3);themes.append(theme4);themes.append(theme5);themes.append(theme6)
            emojiChoices = themes.randomElement()!
            }
        let cardnumber = cardButtons.firstIndex(of: sender)!
        game.chooseCard(at:cardnumber)
        updateViewFromModel()
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for:card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
            }
        score = game.gameScore
        flipCount = game.GameFlipcount
        }
    var emojiChoices: [String]!
    var emoji = [Int:String]()
    func emoji(for card: Card) -> String{
            var emojis = emojiChoices!
            if emoji[card.identifier] == nil, emojis.count > 0{
                let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
                emoji[card.identifier] = emojis.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? ""
    }
}


