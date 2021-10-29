//
//  SetupGameViewController.swift
//  iMemory
//
//  Created by Justin Bergeron on 10/15/18.
//  Copyright © 2018 Justin Bergeron. All rights reserved.
//

import UIKit

extension GameViewController {
 
    func setupGameBoard() {
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        //Reset score
        myScore = 0
        
        //UI detials
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        backgroundImage.image = UIImage(named: "background")
        self.view.addSubview(backgroundImage)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 60, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 80, height: 120)
        
        //Collection view for our cards
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCell")
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.backgroundView = backgroundImage
        self.view.addSubview(myCollectionView)
        
        //UI for "Me" Button
        myProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        myProfile.center = CGPoint(x: w - 60, y: h - 80)
        myProfile.setTitle("Me", for: UIControl.State.normal)
        myProfile.backgroundColor = UIColor(red:0.77, green:0.36, blue:0.10, alpha:1.0)
        myProfile.layer.shadowColor = UIColor.white.cgColor
        myProfile.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        myProfile.layer.shadowOpacity = 0.8
        myProfile.layer.shadowRadius = 5.0
        myProfile.layer.cornerRadius = 10.0
        myProfile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GameViewController.myProfileClicked)))
        self.view.addSubview(myProfile)
        
        //UI for "New" Button
        newGame = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        newGame.center = CGPoint(x: 60, y: h - 80)
        newGame.setTitle("New", for: UIControl.State.normal)
        newGame.backgroundColor = UIColor(red:0.04, green:0.10, blue:0.55, alpha:1.0)
        newGame.layer.shadowColor = UIColor.white.cgColor
        newGame.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        newGame.layer.shadowOpacity = 0.8
        newGame.layer.shadowRadius = 5.0
        newGame.layer.cornerRadius = 10.0
        newGame.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GameViewController.newGameClicked(_:))))
        self.view.addSubview(newGame)
        
        //UI for Score Label
        myScoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 140, height: 60))
        myScoreLabel.center = CGPoint(x: w/2 + 10, y: h - 80)
        myScoreLabel.lineBreakMode = .byWordWrapping
        myScoreLabel.numberOfLines = 2
        myScoreLabel.textColor = UIColor.white
        myScoreLabel.textAlignment = .left
        myScoreLabel.text = "Turns: \(myScore)\nLevel: \(game.myDifficulty)"
        self.view.addSubview(myScoreLabel)
    }
}
