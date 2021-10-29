//
//  SetupHistoryViewController.swift
//  iMemory
//
//  Created by Justin Bergeron on 10/15/18.
//  Copyright © 2018 Justin Bergeron. All rights reserved.
//

import UIKit

extension HistoryViewController {
    
    func setupUserHistory() {
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        //Checks user defaults to see if ther is any game history
        let decoder = UserDefaults.standard.object(forKey: "savedGame")
        if decoder == nil {
            //if not return an empty array
            decodedData = []
        } else {
            //Assign the saved game history to our decoded data array
            let decoded = NSKeyedUnarchiver.unarchiveObject(with: decoder as! Data) as! [savedItem]
            decodedData = decoded
        }
        //UI details
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
                
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        backgroundImage.image = UIImage(named: "background")
        self.view.addSubview(backgroundImage)
        
        //UI for User Game History table
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - 80))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.estimatedRowHeight = 80
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.separatorStyle = .none
        myTableView.backgroundColor = UIColor.clear
        self.view.addSubview(myTableView)
        
        // UI for "Done" Button
        dismissButton = UIButton(frame: CGRect(x: 0, y: barHeight - 40, width: 200, height: 50))
        dismissButton.center = CGPoint(x: displayWidth / 2 , y: displayHeight - 50)
        dismissButton.setTitle("Done", for: UIControl.State.normal)
        dismissButton.backgroundColor = UIColor(red:0.32, green:0.32, blue:0.32, alpha:1.0)
        dismissButton.layer.shadowColor = UIColor.white.cgColor
        dismissButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        dismissButton.layer.shadowOpacity = 0.8
        dismissButton.layer.shadowRadius = 5.0
        dismissButton.layer.cornerRadius = 4.0
        dismissButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HistoryViewController.dismissProfile(_:))))
        self.view.addSubview(dismissButton)
    }
}
