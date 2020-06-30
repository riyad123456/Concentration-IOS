//
//  ConcentrationModel.swift
//  Concentration
//
//  Created by Mac on 6/28/20.
//  Copyright © 2020 Riyad. All rights reserved.
//

import Foundation

class ConcentrationModel{
    var cards = [Card]()
    var indexOfOneAndOnlyOneFaceUpCard: Int?
    var gameScore = 0
    var GameFlipcount = 0
    func chooseCard(at index: Int){
        GameFlipcount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched=true
                    cards[index].isMatched=true
                    cards[matchIndex].isInvolvedInMismatch=false
                    cards[index].isInvolvedInMismatch=false
                    gameScore+=2
                }
                else{
                    if cards[matchIndex].isInvolvedInMismatch {
                        gameScore -= 1
                    }
                    if cards[index].isInvolvedInMismatch{
                        gameScore -= 1
                    }
                    cards[matchIndex].isInvolvedInMismatch=true
                    cards[index].isInvolvedInMismatch=true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOneFaceUpCard = nil
            }   else {
            for flipDownIndex in cards.indices{
                cards[flipDownIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyOneFaceUpCard = index
        }
    }
}
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
            }
        cards.shuffle()
            }

}
