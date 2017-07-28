//
//  Game.swift
//  FlashMemoryCards
//
//  Created by Jorge Guerra on 7/19/17.
//  Copyright © 2017 Jorge Guerra. All rights reserved.
//

import Foundation
import AVFoundation

protocol MatchingGameDelegate {
    func game(_ game: Game, hideCards cards: [Int])

}

struct Game {
    var deckOfCards = DeckOfCards()
    let synthesizer = AVSpeechSynthesizer()
    var gameDelegate: MatchingGameDelegate?
    
    var unmatchedCardsRevealed: [Int] = []
    
    mutating func flipCard(atIndexnumber index: Int) -> Bool {
        if unmatchedCardsRevealed.count < 2 {
            unmatchedCardsRevealed.append(index)
            return true
        } else {
                resetUnmatchedCards()
            return false
        }
        
    }
        
    mutating func resetUnmatchedCards() {
      self.gameDelegate?.game(self, hideCards: unmatchedCardsRevealed)
        unmatchedCardsRevealed.removeAll()
    }
    
    
    func speakCard(number cardTag: Int) {
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: deckOfCards.dealtCards[cardTag])
        synthesizer.speak(utterance)
        
    }
    
    
}
