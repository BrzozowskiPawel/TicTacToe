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
    @IBOutlet weak var turnLabel: UILabel!
    
    var playerType: String?
    var enemyType: String?
    var tilesPlaced = 0
    
    var timer: Timer?
    
    // Add 1 second more becuase last second is to show that time is up!
    var seconds:Int = 6
    
    var currentMove: String?
    // Value being send to next VC
    var playerHasWon: Bool?
    var draft: Bool?
    
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
        
        // Set up turn label to player (always is starting)
        setTurnLabel(currentPlayer: self.playerType!)
        currentMove = playerType!
        
        // Initialize timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStarted), userInfo: nil, repeats: true)
        
        // Update the label
        timeLabel.text = "0:0\(seconds - 1)"
    }
    
    @objc func timerStarted() {
        // Reset the label color
        timeLabel.textColor = UIColor.black
        
        // Decrement the counter
        seconds -= 1
        
        // Update the label. (-1 because after 0:00 wait 1 sec before enemy turn)
        timeLabel.text = "0:0\(seconds - 1)"
        
        print("timer: \(seconds)")
        // Stop the timer if it reaches zero
        if seconds == 1 {
            
            timeLabel.textColor = UIColor.red
            timer?.invalidate()
            seconds = 6
            print("END OF TIME!!!")
            if currentMove == playerType! {
                currentMove = enemyType!
                enemyMove()
            }
        }
        if currentMove == enemyType! {
            timer?.invalidate()
        }
    }
    
    // Hide NavigationController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        print("APEAR")
        if playerHasWon != nil {
            print("DISMISS")
            dismiss(animated: true, completion: nil)
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        print("GameVC disapear")
    }
    
    
    func setTurnLabel(currentPlayer: String) {
        turnLabel.text = "Player \(currentPlayer)’s Turn"
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
        // Buttons setup
        setDefaultImagesForButtons()
        
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
            
            // Stop timer
            timer?.invalidate()
            self.seconds = 6
            print("Clicked on tile: \(tileId) timer should be reseted")
            return true
        } else {
            print("Sorry already occupied by: \(occupiedTiles[tileId]!)")
            return false
        }
    }
    
    func enemyMove() {
        
        guard currentMove! == enemyType! else {
            return
        }
        
        var stilChooseNumber = true
        if tilesPlaced < 9 && playerHasWon == nil && draft == nil {
            // Dispaly enemy type turn in turnLabel
            setTurnLabel(currentPlayer: self.enemyType!)
            
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
                    tilesPlaced += 1
                    if gameOver(winserType: self.enemyType!) {
                        print("CPU WON!")
                        playerHasWon = false
                        timer?.invalidate()
                        goToGameOverVC()
                        
                    }
                }
            }
        }
        if playerHasWon == nil {
            print("number of \(tilesPlaced), bool: \(stilChooseNumber)")
            // Seting up a label for PLAYER turn
            setTurnLabel(currentPlayer: self.playerType!)
            currentMove = self.playerType!
            setTimerForPlaerMove()
            // Update the label. (-1 because after 0:00 wait 1 sec before enemy turn)
            timeLabel.text = "0:0\(seconds - 1)"
        }
    }
    
    func gameOver(winserType: String) -> Bool{
        if checkForWinInRows(winerType: winserType) {
            return true
        } else if checkForWinInColumns(winerType: winserType) {
            return true
        } else if checkForWinInDiagonals(winerType: winserType) {
            return true
        } else {
            if tilesPlaced == 9 {
                self.draft = true
                goToGameOverVC()
                timer?.invalidate()
            }
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
    
    func setTimerForPlaerMove() {
        // Initialize timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStarted), userInfo: nil, repeats: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameOverVC = segue.destination as? GameOverViewController {
            gameOverVC.draft = self.draft
            gameOverVC.playerHasWon = self.playerHasWon
        }
    }
    
    func goToGameOverVC() {
        performSegue(withIdentifier: "GameOverSegue", sender: nil)
    }
    
    @IBAction func buttonA1Pressed(_ sender: Any) {
        if tileIsFree(tileId: 1) {
            buttonA1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        currentMove = enemyType!
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
            self.playerHasWon = true
            goToGameOverVC()
            timer?.invalidate()
        } else {
            enemyMove()
        }
        
    }
    
    @IBAction func buttonA2Pressed(_ sender: Any) {
        if tileIsFree(tileId: 2) {
            buttonA2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        currentMove = enemyType!
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
            self.playerHasWon = true
            goToGameOverVC()
            timer?.invalidate()
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonA3Pressed(_ sender: Any) {
        if tileIsFree(tileId: 3) {
            buttonA3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        currentMove = enemyType!
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
            self.playerHasWon = true
            goToGameOverVC()
            timer?.invalidate()
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonB1Pressed(_ sender: Any) {
        if tileIsFree(tileId: 4) {
            buttonB1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        currentMove = enemyType!
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
            self.playerHasWon = true
            goToGameOverVC()
            timer?.invalidate()
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonB2Pressed(_ sender: Any) {
        if tileIsFree(tileId: 5) {
            buttonB2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        currentMove = enemyType!
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
            self.playerHasWon = true
            goToGameOverVC()
            timer?.invalidate()
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonB3Pressed(_ sender: Any) {
        if tileIsFree(tileId: 6) {
            buttonB3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        currentMove = enemyType!
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
            self.playerHasWon = true
            goToGameOverVC()
            timer?.invalidate()
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonC1Pressed(_ sender: Any) {
        if tileIsFree(tileId: 7) {
            buttonC1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        currentMove = enemyType!
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
            self.playerHasWon = true
            goToGameOverVC()
            timer?.invalidate()
        } else {
            enemyMove()
        }
    }
    @IBAction func buttonC2Pressed(_ sender: Any) {
        if tileIsFree(tileId: 8) {
            buttonC2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        currentMove = enemyType!
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
            self.playerHasWon = true
            goToGameOverVC()
            timer?.invalidate()
        } else {
            enemyMove()
        }
    }
    
    @IBAction func buttonC3Pressed(_ sender: Any) {
        if tileIsFree(tileId: 9) {
            buttonC3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        currentMove = enemyType!
        if gameOver(winserType: self.playerType!) {
            print("PLAYER WON!")
            self.playerHasWon = true
            goToGameOverVC()
            timer?.invalidate()
        } else {
            enemyMove()
        }
    }
    
    func setDefaultImagesForButtons() {
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
    }
    
}
