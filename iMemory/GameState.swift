//
//  GameState.swift
//  iMemory
//
//  Created by Justin Bergeron on 10/15/18.
//  Copyright © 2018 Justin Bergeron. All rights reserved.
//

//Requirements
//
//- Standard memory card game, sometimes known as concentration
//- We want a built application, in Xcode that runs on iPhone X.
//- No Storyboard.
//- Don’t care on language preference
//
//App Should
//
//- Display your score (number of moves it took you to complete the game)
//- Start a new game (user should be able to select N which also defines the complexity for the game)
//- The game state should persist
//- Profile view that shows a history table of all your past game scores
//- Code should include mock function to send state to a server (obviously there is no server but the function would get as far as needed until the “send data” spot)

import UIKit

//The state if the game were to crash
//After every card flip update state

class GameState: NSObject, NSCoding {
    var cards: [CardInfo]
    var myScore: Int
    var myDifficulty: String
    
    override init() {
        
        cards = [CardInfo]()
        myScore = 0
        myDifficulty = "Beginner"
    }
    required init(coder aDecoder: NSCoder) {
        cards = aDecoder.decodeObject(forKey: "cards") as! [CardInfo]
        myScore = aDecoder.decodeInteger(forKey: "myScore")
        myDifficulty = aDecoder.decodeObject(forKey: "myDifficulty") as! String
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(cards, forKey: "cards")
        aCoder.encode(myScore, forKey: "myScore")
        aCoder.encode(myDifficulty, forKey: "myDifficulty")
    }
}
