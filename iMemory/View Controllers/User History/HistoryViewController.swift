//
//  HistoryViewController.swift
//  iMemory
//
//  Created by Justin Bergeron on 10/15/18.
//  Copyright © 2018 Justin Bergeron. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Variable
    var decodedData: [savedItem] = []
    
    //UI Elements
    var dismissButton: UIButton!
    var backgroundImage: UIImageView!
    var myLabel: UILabel!
    var myTableView: UITableView!
    var emptyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUserHistory()
        
    }
    
    //Create tableview to hold player history. Append to an array and save.
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    //User clicks "Done" button to dismiss VC
    @objc func dismissProfile(_ recognizer: UITapGestureRecognizer) {
        self.presentingViewController?.dismiss(animated: true, completion: { () -> Void in })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decodedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)

        //UI for Game History Cells
        let cellData = decodedData[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 8.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel!.text = "\(cellData.savedGame)"
        cell.textLabel?.contentMode = .center
        return cell
    }
}
