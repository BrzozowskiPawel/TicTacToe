//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Paweł Brzozowski on 15/12/2021.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var buttonA1: UIButton!
    @IBOutlet weak var buttonA2: UIButton!
    @IBOutlet weak var buttonA3: UIButton!
    @IBOutlet weak var buttonB1: UIButton!
    @IBOutlet weak var buttonB2: UIButton!
    @IBOutlet weak var buttonB3: UIButton!
    @IBOutlet weak var buttonC1: UIButton!
    @IBOutlet weak var buttonC2: UIButton!
    @IBOutlet weak var buttonC3: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameView: UIView!
    
    
    var playerType: String?
    var enemyType: String?
    var tilesNumber = 0
    
    var occupiedTiles = [
        1: "",
        2: "",
        3: "",
        4: "",
        5: "",
        6: "",
        7: "",
        8: "",
        9: "",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureScreen()
        
        // Set type for enemy
        setEnemyType()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setEnemyType() {
        if self.playerType! == "X" {
            enemyType = "O"
        } else {
            enemyType = "X"
        }
        print("Set enemy type for: \(enemyType!)")
    }
    
    func configureScreen() {
        // Setup the buttons FIRST ROW
        buttonA1.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonA1.setTitle("", for: .normal)
        buttonA2.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonA2.setTitle("", for: .normal)
        buttonA3.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonA3.setTitle("", for: .normal)

        // Setup the buttons SECOND ROW
        buttonB1.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonB1.setTitle("", for: .normal)
        buttonB2.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonB2.setTitle("", for: .normal)
        buttonB3.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonB3.setTitle("", for: .normal)
        
        // Setup the buttons THIRD ROW
        buttonC1.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonC1.setTitle("", for: .normal)
        buttonC2.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonC2.setTitle("", for: .normal)
        buttonC3.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonC3.setTitle("", for: .normal)
        
        // Set corner radius for game
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 15
        
        // Set corner radius for gameView
        gameView.layer.cornerRadius = 15
    }
    
    // MARK: - BUTTON PRESSED
    
    func tileIsFree(tileId: Int) -> Bool{
        if occupiedTiles[tileId] == "" {
            occupiedTiles[tileId] = self.playerType!
            return true
        } else {
            print("Sorry already occupied by: \(occupiedTiles[tileId]!)")
            return false
        }
    }
    
    func enemyMove() {
        var stilChooseNumber = true
        if tilesNumber < 9 {
            while stilChooseNumber {
                let randNum = Int.random(in: 1...9)
                if occupiedTiles[randNum] == "" {
                    occupiedTiles[randNum] = self.enemyType!
                    
                    switch randNum {
                    case 1:
                        buttonA1.setImage(UIImage(named: "\(self.enemyType!)_SPACE.png"), for: .normal)
                    case 2:
                        buttonA2.setImage(UIImage(named: "\(self.enemyType!)_SPACE.png"), for: .normal)
                    case 3:
                        buttonA3.setImage(UIImage(named: "\(self.enemyType!)_SPACE.png"), for: .normal)
                    case 4:
                        buttonB1.setImage(UIImage(named: "\(self.enemyType!)_SPACE.png"), for: .normal)
                    case 5:
                        buttonB2.setImage(UIImage(named: "\(self.enemyType!)_SPACE.png"), for: .normal)
                    case 6:
                        buttonB3.setImage(UIImage(named: "\(self.enemyType!)_SPACE.png"), for: .normal)
                    case 7:
                        buttonC1.setImage(UIImage(named: "\(self.enemyType!)_SPACE.png"), for: .normal)
                    case 8:
                        buttonC2.setImage(UIImage(named: "\(self.enemyType!)_SPACE.png"), for: .normal)
                    case 9:
                        buttonC3.setImage(UIImage(named: "\(self.enemyType!)_SPACE.png"), for: .normal)
                    default:
                        print("Error! Wrong number")
                    }
                    stilChooseNumber = false
                    tilesNumber += 1
                    if gameOver(winserType: self.enemyType!) {
                        print("CPU WON!")
                    }
                }
            }
        }
        print("number of \(tilesNumber), bool: \(stilChooseNumber)")

    }
    
    func gameOver(winserType: String) -> Bool{
        if checkForWinInRows(winerType: winserType) {
            return true
        } else if checkForWinInColumns(winerType: winserType) {
            return true
        } else if checkForWinInDiagonals(winerType: winserType) {
            return true
        } else {
            return false
        }
    }
    
    func checkForWinInRows(winerType: String) -> Bool{
        if occupiedTiles[1] == winerType && occupiedTiles[2] == winerType && occupiedTiles[3] == winerType {
            return true
        } else if occupiedTiles[4] == winerType && occupiedTiles[5] == winerType && occupiedTiles[6] == winerType {
            return true
        } else if occupiedTiles[7] == winerType && occupiedTiles[8] == winerType && occupiedTiles[9] == winerType {
            return true
        } else {
            return false
        }
    }
    
    func checkForWinInColumns(winerType: String) -> Bool{
        if occupiedTiles[1] == winerType && occupiedTiles[4] == winerType && occupiedTiles[7] == winerType {
            return true
        } else if occupiedTiles[2] == winerType && occupiedTiles[5] == winerType && occupiedTiles[8] == winerType {
            return true
        } else if occupiedTiles[3] == winerType && occupiedTiles[6] == winerType && occupiedTiles[9] == winerType {
            return true
        } else {
            return false
        }
    }
    
    func checkForWinInDiagonals(winerType: String) -> Bool{
        if occupiedTiles[1] == winerType && occupiedTiles[5] == winerType && occupiedTiles[9] == winerType {
            return true
        } else if occupiedTiles[3] == winerType && occupiedTiles[5] == winerType && occupiedTiles[7] == winerType {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func buttonA1Pressed(_ sender: Any) {
        if tileIsFree(tileId: 1) {
            buttonA1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesNumber += 1
        }
        
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
        } else {
            enemyMove()
        }
        
    }
    
    @IBAction func buttonA2Pressed(_ sender: Any) {
        if tileIsFree(tileId: 2) {
            buttonA2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesNumber += 1
        }
        
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonA3Pressed(_ sender: Any) {
        if tileIsFree(tileId: 3) {
            buttonA3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesNumber += 1
        }
        
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonB1Pressed(_ sender: Any) {
        if tileIsFree(tileId: 4) {
            buttonB1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesNumber += 1
        }
        
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonB2Pressed(_ sender: Any) {
        if tileIsFree(tileId: 5) {
            buttonB2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesNumber += 1
        }
        
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonB3Pressed(_ sender: Any) {
        if tileIsFree(tileId: 6) {
            buttonB3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesNumber += 1
        }
        
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonC1Pressed(_ sender: Any) {
        if tileIsFree(tileId: 7) {
            buttonC1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesNumber += 1
        }
        
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
        } else {
            enemyMove()
        }
    }
    @IBAction func buttonC2Pressed(_ sender: Any) {
        if tileIsFree(tileId: 8) {
            buttonC2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesNumber += 1
        }
        
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonC3Pressed(_ sender: Any) {
        if tileIsFree(tileId: 9) {
            buttonC3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesNumber += 1
        }
        
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
        } else {
            enemyMove()
        }
    }
    
    
}
