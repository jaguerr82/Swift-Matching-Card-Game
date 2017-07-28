//
//  arrayShuffle.swift
//  FlashMemoryCards
//
//  Created by Jorge Guerra on 7/19/17.
//  Copyright © 2017 Jorge Guerra. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        for _ in 1...self.count {
            self.sort { (_,_) in arc4random() < arc4random() }
        
        }
    }
}
