//
//  DeckOfCards.swift
//  FlashMemoryCards
//
//  Created by Jorge Guerra on 7/19/17.
//  Copyright © 2017 Jorge Guerra. All rights reserved.
//

import Foundation

struct DeckOfCards {

    var nameList = ["Afghanistan","Armenia","Azerbaijan","Bahrain","Bangladesh","Bhutan","Brunei","Cambodia","China","Cyprus","Georgia","India"]

    var dealtCards : [String] = []
    
    let numberOfMatches = 6

    init() {
        drawCards()
    }

    mutating func drawCards() {
        dealtCards.removeAll()
        nameList.shuffle()
        for i in 0..<numberOfMatches {
            dealtCards.append(nameList[i])
            dealtCards.append(nameList[i])
        }
        dealtCards.shuffle()
    }
}











//"Indonesia","Iran","Iraq", "Israel","Japan","Jordan","Kazakhstan","Kuwait","Kyrgyzstan","Laos","Lebanon","Malaysia","Maldives","Mongolia","Myanmar","Nepal","North Korea","Oman","Pakistan","Palestine","Philippines","Qatar","Russia","Saudi Arabia","Singapore","South Korea", "Sri Lanka","Syria","Taiwan","Tajikistan","Thailand","Timor-Leste","Turkey","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen"]
