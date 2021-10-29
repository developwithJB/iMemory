//
//  SetupNewGameViewController.swift
//  iMemory
//
//  Created by Justin Bergeron on 10/15/18.
//  Copyright © 2018 Justin Bergeron. All rights reserved.
//

import UIKit

extension NewGameViewController {
    
    func setupNewGame() {
    
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    
    //UI detials
    backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
    backgroundImage.image = UIImage(named: "background")
    self.view.addSubview(backgroundImage)
    
    //iMemory Logo
    logoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: 200))
    logoImage.image = UIImage(named: "iMemory")
    logoImage.contentMode = .scaleAspectFit
    logoImage.center = CGPoint(x: w/2, y: h/2 - 200)
    self.view.addSubview(logoImage)
    
    //UI for "Beginner" Button
    beginnerButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    beginnerButton.center = CGPoint(x: w/2, y: h/2)
    beginnerButton.setTitle("Beginner", for: UIControl.State.normal)
    beginnerButton.backgroundColor = UIColor(red:0.09, green:0.30, blue:0.09, alpha:1.0)
    beginnerButton.layer.shadowColor = UIColor.white.cgColor
    beginnerButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    beginnerButton.layer.shadowOpacity = 0.8
    beginnerButton.layer.shadowRadius = 5.0
    beginnerButton.layer.cornerRadius = 4.0
    beginnerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NewGameViewController.beginnerButton(_:))))
    self.view.addSubview(beginnerButton)
    
    //UI for "Advanced" Button
    advancedButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    advancedButton.center = CGPoint(x: w/2, y: h/2 + 100)
    advancedButton.setTitle("Advanced", for: UIControl.State.normal)
    advancedButton.backgroundColor = UIColor(red:0.51, green:0.16, blue:0.16, alpha:1.0)
    advancedButton.layer.shadowColor = UIColor.white.cgColor
    advancedButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    advancedButton.layer.shadowOpacity = 0.8
    advancedButton.layer.shadowRadius = 5.0
    advancedButton.layer.cornerRadius = 4.0
    advancedButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NewGameViewController.advancedButton(_:))))
    self.view.addSubview(advancedButton)
    
    
    }
}
