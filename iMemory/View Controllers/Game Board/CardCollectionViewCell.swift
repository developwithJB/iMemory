//
//  CardCollectionViewCell.swift
//  iMemory
//
//  Created by Justin Bergeron on 10/15/18.
//  Copyright © 2018 Justin Bergeron. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    var frontImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    var backImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    var card:CardInfo?
    
    func setCard(_ card:CardInfo) {
        //Keeps track of the card that is passed in
        self.card = card
        
        //If the card is already matched it will end the func
        //Eliminates reusable cell errors
        if card.paired == true {
            //If paired, make the image views invisible
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
        } else {
            //If not paired, make sure the images are visible
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        
        //Determine the flipped state
        if card.flipped == true {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
    func flip() {
        //Initial flip of a card
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromTop, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack() {
        //Flip back if cards dont match
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
    func remove() {
        
        //Removes imageviews from being visible
        backImageView.alpha = 0
        
        //Disolve card off board
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
    }
}
