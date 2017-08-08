//
//  GameViewController.swift
//  FlashMemoryCards
//
//  Created by Jorge Guerra on 7/17/17.
//  Copyright © 2017 Jorge Guerra. All rights reserved.
//

import UIKit
import LTMorphingLabel
import MZTimerLabel


class GameViewController: UIViewController, MatchingGameDelegate {
    @IBOutlet weak var practiceMorphLabel: LTMorphingLabel!
    @IBOutlet weak var cardButton: UIButton!
    
    var counter = 1
    var game = Game()
    var gameNumber = 1
    var stopwatch: MZTimerLabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.newGame()  
        stopwatch = MZTimerLabel.init(label: timerLabel)
        stopwatch.timeFormat = "mm:ss"
        stopwatch?.start()
        game.gameDelegate = self
        practiceMorphLabel.morphingEffect = .burn
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        let tagNum = sender.tag
        if game.flipCard(atIndexnumber: tagNum - 1) {
            let thisImage = UIImage(named: game.deckOfCards.dealtCards[tagNum - 1])
            
            UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromTop, animations: {
                sender.setImage(thisImage, for: .normal)
            }, completion: nil)
            if game.cardsRemaining.isEmpty {
                displayGameOver()
            }
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        for tagNum in 1...12 {
            if let thisButton = self.view.viewWithTag(tagNum) as? UIButton {
                
                UIView.transition(with: thisButton, duration: 0.5, options: .transitionFlipFromTop, animations: {
                    thisButton.setImage(#imageLiteral(resourceName: "CardBack"), for: .normal)
                }, completion: nil)
            }
        }
        
        gameNumber += 1
        practiceMorphLabel.text = "Game #\(gameNumber)"
        
        game.newGame()
        stopwatch.reset()
        stopwatch.start()
        
    }
    
    func displayGameOver() {
        practiceMorphLabel.text = "Game Over!"
        stopwatch.pause()
    }
    
    func game(_ game: Game, hideCards cards: [Int]) {
        
        let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            for cardIndex in cards {
                if let thisButton = self.view.viewWithTag(cardIndex + 1) as? UIButton {
                 
                    UIView.transition(with: thisButton, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                        thisButton.setImage(#imageLiteral(resourceName: "CardBack"), for: .normal)
                    }, completion: nil)
                    
                    
                }
            }
            self.game.waitingForHidingCards = false //All unmatched crds are hidden
        }
    }
}



