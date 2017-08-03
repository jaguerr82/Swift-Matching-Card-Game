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
    var sound = AVAudioPlayer()
    var waitingForHidingCards = false
    
    
    var unmatchedCardsRevealed: [Int] = []
    
    mutating func flipCard(atIndexnumber index: Int) -> Bool {
        
        if waitingForHidingCards {return false}
        if !unmatchedCardsRevealed.isEmpty && unmatchedCardsRevealed[0] == index {return false}
        if unmatchedCardsRevealed.count < 2 {
            unmatchedCardsRevealed.append(index)
            
            if unmatchedCardsRevealed.count == 2 {
                let card1Name = deckOfCards.dealtCards[unmatchedCardsRevealed[0]]
                let card2Name = deckOfCards.dealtCards[unmatchedCardsRevealed[1]]
                
                if card1Name == card2Name { //2nd card is a match
                    self.speakCard(number: index)
                    unmatchedCardsRevealed.removeAll()
                } else {                    //2nd card is not a match
                    resetUnmatchedCards()
                }
            }
            playRevealSound()
            
            return true
        } else {
            print("ERROR: This should never be here")
            return false
            
        }
        
    }
    mutating func newGame() {
        playShuffleSound()
        deckOfCards.drawCards()
    }
    
    mutating func resetUnmatchedCards() {
        waitingForHidingCards = true //To be reset in the hideCards method
        self.gameDelegate?.game(self, hideCards: unmatchedCardsRevealed)
        unmatchedCardsRevealed.removeAll()
    }
    //MARK: - Sound Methods
    mutating func playRevealSound() {
        let path = Bundle.main.path(forResource: "card-flip", ofType: "mp3")
        playSound(withPath: path!)
    }
    mutating func playShuffleSound() {
        let path = Bundle.main.path(forResource: "shuffle", ofType: "wav")
        playSound(withPath: path!)
    }
    
    //Plays any sound that you pass a path to
    mutating func playSound(withPath path: String) {
        let soundURL = URL(fileURLWithPath: path)
        do {
            try sound = AVAudioPlayer(contentsOf: soundURL)
            sound.prepareToPlay()
        } catch {
            print("ERROR! Couldn't load sound file")
        }
        sound.play()
    }
    
    
    func speakCard(number cardTag: Int) {
        
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: deckOfCards.dealtCards[cardTag])
        synthesizer.speak(utterance)
        
        
    }
    
}

