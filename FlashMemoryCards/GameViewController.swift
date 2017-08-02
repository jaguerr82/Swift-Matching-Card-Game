//
//  GameViewController.swift
//  FlashMemoryCards
//
//  Created by Jorge Guerra on 7/17/17.
//  Copyright © 2017 Jorge Guerra. All rights reserved.
//

import UIKit
import LTMorphingLabel

class GameViewController: UIViewController, MatchingGameDelegate {
    @IBOutlet weak var practiceMorphLabel: LTMorphingLabel!
    @IBOutlet weak var cardButton: UIButton!
    
    var counter = 1
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.gameDelegate = self
        practiceMorphLabel.morphingEffect = .burn
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        let tagNum = sender.tag
        if game.flipCard(atIndexnumber: tagNum - 1) {
            let thisImage = UIImage(named: game.deckOfCards.dealtCards[tagNum - 1])
            
            
            UIView.transition(with: sender, duration: 1.0, options: .transitionFlipFromTop, animations: {
             sender.setImage(thisImage, for: .normal)
            }, completion: nil)
            
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        
        practiceMorphLabel.morphingEffect = .burn
        practiceMorphLabel.text = game.deckOfCards.dealtCards[counter]
        counter += 1
        counter %= game.deckOfCards.dealtCards.count
        
        for tagNum in 1...12 {
            if let thisButton = self.view.viewWithTag(tagNum) as? UIButton {
                thisButton.setImage(#imageLiteral(resourceName: "CardBack"), for: .normal)
            }
            
        }
        game.deckOfCards.drawCards()
//        gameNumber += 1
//        gameLabel.text = "Game #\(gameNumber)"
        
        game.newGame()
        
    }
    
    func game(_ game: Game, hideCards cards: [Int]) {
        for cardIndex in cards {
            if let thisButton = self.view.viewWithTag(cardIndex + 1) as? UIButton {
                thisButton.setImage(#imageLiteral(resourceName: "CardBack"), for: .normal)
                
                
            }
        }
        
        
    }
    
    
}



