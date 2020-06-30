//
//  Card.swift
//  Concentration
//
//  Created by Mac on 6/28/20.
//  Copyright © 2020 Riyad. All rights reserved.
//

import Foundation
struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    var isInvolvedInMismatch = false
    static var identifierFactory = 0
    static func getUniqueId() -> Int {
        identifierFactory+=1
        return  identifierFactory
    }
    init( ){
        self.identifier = Card.getUniqueId()
        }
    
}
