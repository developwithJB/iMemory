//
//  CardModel.swift
//  iMemory
//
//  Created by Justin Bergeron on 10/15/18.
//  Copyright © 2018 Justin Bergeron. All rights reserved.
//

import Foundation

class CardModel {
    
    //Pass in the users selected difficulty to determine what shuffle
    func shuffledCards(_ difficulty: String) -> [CardInfo]{
        
        //Declare our number storage array so we dont duplicate pairs
        var generatedNumbers = [Int]()
        
        //Declare an array to generate cards
        var generatedCards = [CardInfo]()
        
        //Randomly generate the pairs
        while generatedNumbers.count < 8 {
            
            //Get a random number
            let randomNum = arc4random_uniform(16) + 1
            
            //Make sure we only have unique pairs of cards
            if generatedNumbers.contains(Int(randomNum)) == false {
                
                //Store our number
                generatedNumbers.append(Int(randomNum))
                
                //Creates the first card object
                let cardOne = CardInfo()
                cardOne.imageName = "card\(randomNum)"
                
                generatedCards.append(cardOne)
                
                //create the second card object
                let cardTwo = CardInfo()
                cardTwo.imageName = "card\(randomNum)"
                
                generatedCards.append(cardTwo)
            }
            
        }
        
        //Randomize the array
        if difficulty == "Beginner" {
            //Generating a random number to switch with one random index
            let randomNum = Int(arc4random_uniform((UInt32(generatedCards.count))))
            //Only swaps one card with another
            let tempStorage = generatedCards[0]
            generatedCards[0] = generatedCards[randomNum]
            generatedCards[randomNum] = tempStorage
        } else {
            //For the amount of paired cards, it will loop through and swap indexes with one of the cards
            for i in 0...generatedCards.count-1 {
                //Find a random index to swap
                let randomNum = Int(arc4random_uniform((UInt32(generatedCards.count))))
                //Swap cards
                let tempStorage = generatedCards[i]
                generatedCards[i] = generatedCards[randomNum]
                generatedCards[randomNum] = tempStorage
            }
        
        }
        
        return generatedCards
    }
}
