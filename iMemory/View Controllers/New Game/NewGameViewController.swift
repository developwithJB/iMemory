//
//  StartViewController.swift
//  iMemory
//
//  Created by Justin Bergeron on 10/15/18.
//  Copyright © 2018 Justin Bergeron. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController {

    //Variable
    var model = CardModel()
    
    //UI Elements
    var backgroundImage: UIImageView!
    var logoImage: UIImageView!
    var beginnerButton: UIButton!
    var advancedButton: UIButton!
    
    //New Game Delegate
    var delegate: NewGameDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNewGame()
    }

    //User Clicked "Beginner" Button
    @objc func beginnerButton(_ recognizer: UITapGestureRecognizer) {
        delegate?.newGameRequirements(difficulty: "Beginner", restart: false)
        self.presentingViewController?.dismiss(animated: true, completion: { () -> Void in
        })
    }
    //User Clicked "Advanced" Button
    @objc func advancedButton(_ recognizer: UITapGestureRecognizer) {
        delegate?.newGameRequirements(difficulty: "Advanced", restart: true)
        self.presentingViewController?.dismiss(animated: true, completion: { () -> Void in
        })
    }

}
