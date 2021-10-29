//
//  ViewController.swift
//  iMemory
//
//  Created by Justin Bergeron on 10/15/18.
//  Copyright © 2018 Justin Bergeron. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    //Variables
    var model = CardModel()
    var cardArray = [CardInfo]()
    
    var flippedCardIndex:IndexPath?
    //UI Elements
    var myCollectionView: UICollectionView!
    var backgroundImage: UIImageView!
    var myProfile: UIButton!
    var newGame: UIButton!
    var myScoreLabel: UILabel!
    //Starting game values
    var myScore = 0
    var myDifficulty = "Beginner"
    var startAdvancedGame = false
    
    //Game State
    let game: GameState
    //Initiating a new GameState
    init() {
        game = GameState()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set title logo
        let logo = UIImage(named: "AppleLogo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        //Check if starting a new game or loading a saved one from mock server
        if game.cards.count == 0 {
            //Call the shuffledCards method of the card model
            cardArray = model.shuffledCards(game.myDifficulty)
            
            //Get board ready to play
            setupGameBoard()
            
            //Add shuffled deck to GameeState
            game.cards = cardArray
            
            //Using Firebase, save GameState to a Realtime Database
            sendGameState(game)
            
        } else {
            //Load saved game state from server
            cardArray = game.cards
            //Get board ready to play
            setupGameBoard()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

       
        if startAdvancedGame == true {
            //Switch difficulty over to Advanced
            cardArray.removeAll()
            myDifficulty = "Advanced"
            cardArray = model.shuffledCards(game.myDifficulty)
            setupGameBoard()
            game.cards = cardArray
            sendGameState(game)
            myScoreLabel.text = "Turns: \(myScore)\nLevel: \(game.myDifficulty)"

        } else {
            //Switch difficulty back to Beginner
            cardArray.removeAll()
            myDifficulty = "Beginner"
            cardArray = model.shuffledCards(game.myDifficulty)
            setupGameBoard()
            game.cards = cardArray
            sendGameState(game)
            myScoreLabel.text = "Turns: \(myScore)\nLevel: \(game.myDifficulty)"
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Get a CardCollectionViewCell object
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        //Get the card that the collection view is will display
        let card = cardArray[indexPath.row]
        
        //From loaded Game State,
        //If the cards were already paired and flipped, hide card
        if card.flipped == true && card.paired == true {
            myCell.backImageView.alpha = 0
        }
        
        //Set Front Image Properties
        let frontImage:UIImage = UIImage(named: card.imageName)!
        myCell.frontImageView.image = frontImage
        myCell.frontImageView.contentMode = .scaleAspectFill
        myCell.contentView.addSubview(myCell.frontImageView)
        
        //Set Back Image Properties
        let backImage:UIImage = UIImage(named: "back")!
        myCell.backImageView.image = backImage
        myCell.backImageView.contentMode = .scaleAspectFill
        myCell.contentView.addSubview(myCell.backImageView)
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //Get the cell that is selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //Get the card that is selected
        let card = cardArray[indexPath.row]
        
        if card.flipped == false && card.paired == false {
            //Flip the selected card
            cell.flip()
            
            //Change status of the selected card
            card.flipped = true
            
            // Determine if its the first or second card thats been selected
            if flippedCardIndex == nil {
                
                //First card flipped
                flippedCardIndex = indexPath
                
            } else {
                
                //Second card flipped, check for matches
                checkForMatches(indexPath)
            }
        }
        
    }
    
    //User Clicked "Me" Button
    @objc func myProfileClicked(_ recognizer: UITapGestureRecognizer) {
        let hvc: HistoryViewController = HistoryViewController()
        self.present(hvc, animated: true) { () -> Void in }
    }
    
    //User Clicked "New" Button
    @objc func newGameClicked(_ recognizer: UITapGestureRecognizer) {
        let ngvc: NewGameViewController = NewGameViewController()
        ngvc.delegate = self
        self.present(ngvc, animated: true) { () -> Void in }
    }
    
    func checkForMatches(_ flippedCardIndex2:IndexPath) {
        //Get each cards current index path
        let cardOneCell = myCollectionView.cellForItem(at: flippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = myCollectionView.cellForItem(at: flippedCardIndex2) as? CardCollectionViewCell
        //Get each cards information
        let cardOne = cardArray[flippedCardIndex!.row]
        let cardTwo = cardArray[flippedCardIndex2.row]
        
        //Compare the cards
        if cardOne.imageName == cardTwo.imageName {
            //Add turn to score
            myScore = myScore + 1
            myScoreLabel.text = "Turns: \(myScore)\nLevel: \(game.myDifficulty)"
            
            //Its a match! Set each cards paired state to true
            cardOne.paired = true
            cardTwo.paired = true
            
            //Remove the cards from the board
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //Check if the user won
            checkFinishedGame()
            
        } else {
            //Add turn to score
            myScore = myScore + 1
            myScoreLabel.text = "Turns: \(myScore)\nLevel: \(game.myDifficulty)"
        
            //Not a match. Keep each cards paired state to false
            cardOne.flipped = false
            cardTwo.flipped = false
            
            //Flip the cards back over
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        //If the indexPath is nil, reload the cell of the first card
        //Protects against scrolling errors, if scrolling was implemented
        if cardOneCell == nil {
            myCollectionView.reloadItems(at: [flippedCardIndex!])
        }
        //Reset flipped card index
        flippedCardIndex = nil
    }
    
    func checkFinishedGame() {
        
        //Determine if we have a win
        var didWin = true
        
        for card in cardArray {
            
            //Check for any non pairings
            if card.paired == false {
                
                //If there is still cards un paired, break out and continue game
                didWin = false
                break
            }
        }
        
        //We have a winner!
        if didWin == true {
            //Notify the user that they have one
            let alertController = UIAlertController(title: "Congratulations!", message: "You won! It only took you \(myScore) turns to conquer iMemory \(game.myDifficulty)! Click Me to see your game history!", preferredStyle: .alert)
            
            //Load a new game after they click ok
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                //run your function here
                self.cardArray = self.model.shuffledCards(self.myDifficulty)
                self.setupGameBoard()
                
            }))
            
            present(alertController, animated: true, completion: nil)
        
            //Save the winning score and difficulty for users history
            let item: [savedItem] = [savedItem(savedGame: myScoreLabel.text!)]
            //Saves the game to users default with key
            let decoder = UserDefaults.standard.object(forKey: "savedGame")
            
            if decoder == nil {
                
                //Array is empty, save new game
                let userDefaults = UserDefaults.standard
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: item)
                userDefaults.set(encodedData, forKey: "savedGame")
                userDefaults.synchronize()
                
            } else {
                
                //Take current saved games and add them to the
                //new game being saved for a new user history new list
                let decoded = NSKeyedUnarchiver.unarchiveObject(with: decoder as! Data) as! [savedItem]
                let appendedItem = decoded + item
                let userDefaults = UserDefaults.standard
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: appendedItem)
                userDefaults.set(encodedData, forKey: "savedGame")
                userDefaults.synchronize()
                
            }
            
        }
        
    }
    
    //Using Firebase you can send data to store the game state so it can persist even on exit
    //- The game state should persist
    //- Code should include mock function to send state to a server (obviously there is no server but the function would get as far as needed until the “send data” spot)
    func sendGameState(_ gs: GameState) {
        
//        ref.child("GameState").child(user.uid).setValue(["gs": game]) {
//            (error:Error?, ref:DatabaseReference) in
//            if let error = error {
//                print("Data could not be saved: \(error).")
//            } else {
//                print("Data saved successfully!")
//            }
//        }
    }

}
//Dispatcher... Receives the action
//Extension to create delegate that handles our game difficulty responses
extension GameViewController: NewGameDelegate {
    func newGameRequirements(difficulty: String, restart: Bool) {
        myScoreLabel.text = "Turns: \(myScore)\nLevel: \(difficulty)"
        startAdvancedGame = restart
        game.myDifficulty = difficulty
        cardArray = model.shuffledCards(game.myDifficulty)
        
        //Get board ready to play
        setupGameBoard()
        
        //Add shuffled deck to GameeState
        game.cards = cardArray
        
    }
}

//Custom UserDefualts Object that allows us to store our user history
class savedItem: NSObject, NSCoding {
    var savedGame: String
    
    init(savedGame: String) {
        self.savedGame = savedGame
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let game = aDecoder.decodeObject(forKey: "savedGame") as! String
        self.init(savedGame: game)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(savedGame, forKey: "savedGame")
    }
}

