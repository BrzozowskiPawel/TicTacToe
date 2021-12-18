//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Paweł Brzozowski on 15/12/2021.
//

import UIKit

class GameViewController: UIViewController {
    
    // IBotlets decralation
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
    
    // Player type: X or O
    var playerType: String?
    // If player is ) then enemy is X and so one
    var enemyType: String?
    // Keep track how many X or O have been placed, make sure to not place more then 9 coz this is grid size.
    var tilesPlaced:Int = 0
    // Timer to inform user how much time he/she got to place his tile.
    var timer: Timer?
    // Add 1 second more becuase last second is to show that time is up!
    var seconds:Int = 6
    //Keep track of who is currenly placing tile
    var currentMove: String?
    // Value being send to next VC
    var playerHasWon: Bool?
    // Check if it's draft
    var draft: Bool?
    
    // Dictonary of tile's state
    var occupiedTiles: [Int: String] = [
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
    
    // Hide/Show NavigationController related to state of game
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if playerHasWon != nil {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }

    // Hide/Show NavigationController related to state of game
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func timerStarted() {
        // Reset the label color
        timeLabel.textColor = UIColor.black
        
        // Decrement the counter
        seconds -= 1
        
        // Update the label. (-1 because after 0:00 wait 1 sec before enemy turn)
        timeLabel.text = "0:0\(seconds - 1)"
        
        // Stop the timer if it reaches zero
        if seconds == 1 {
            
            timeLabel.textColor = UIColor.red
            timer?.invalidate()
            seconds = 6
            if currentMove == playerType! {
                currentMove = enemyType!
                enemyMove()
            }
        }
        if currentMove == enemyType! {
            timer?.invalidate()
        }
    }
    
    // Set different then player type for CPU
    func setEnemyType() {
        if self.playerType! == "X" {
            enemyType = "O"
        } else {
            enemyType = "X"
        }
        print("Set enemy type for: \(enemyType!)")
    }
    
    // MARK: - Game Logic
    
    // Check if tile is free to place a tile here
    func tileIsFree(tileId: Int) -> Bool{
        if occupiedTiles[tileId] == "" {
            occupiedTiles[tileId] = self.playerType!
            
            // Stop timer
            timer?.invalidate()
            self.seconds = 6
            return true
        } else {
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
                        playerHasWon = false
                        timer?.invalidate()
                        goToGameOverVC()
                        
                    }
                }
            }
        }
        if playerHasWon == nil {
            // Seting up a label for PLAYER turn
            setTurnLabel(currentPlayer: self.playerType!)
            currentMove = self.playerType!
            setTimerForPlayerMove()
            // Update the label. (-1 because after 0:00 wait 1 sec before enemy turn)
            timeLabel.text = "0:0\(seconds - 1)"
        }
    }
    
    func gameOver(winserType: String) -> Bool{
        if GameJudge.checkForWinInRows(winerType: winserType, occupiedTiles: occupiedTiles) {
            return true
        } else if GameJudge.checkForWinInColumns(winerType: winserType, occupiedTiles: occupiedTiles) {
            return true
        } else if GameJudge.checkForWinInDiagonals(winerType: winserType, occupiedTiles: occupiedTiles) {
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
    
    
    func setTimerForPlayerMove() {
        // Initialize timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStarted), userInfo: nil, repeats: true)
    }
    
    // MARK: - Segue and prepare functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameOverVC = segue.destination as? GameOverViewController {
            gameOverVC.draft = self.draft
            gameOverVC.playerHasWon = self.playerHasWon
        }
    }
    
    func goToGameOverVC() {
        performSegue(withIdentifier: "GameOverSegue", sender: nil)
    }
    
    // Redundant code after each time player placed tile
    func playerEndMove() {
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
    // MARK: - BUTTON PRESSED
    
    @IBAction func buttonA1Pressed(_ sender: Any) {
        if tileIsFree(tileId: 1) {
            buttonA1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        playerEndMove()
        
    }
    
    @IBAction func buttonA2Pressed(_ sender: Any) {
        if tileIsFree(tileId: 2) {
            buttonA2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        playerEndMove()
    }
    
    @IBAction func buttonA3Pressed(_ sender: Any) {
        if tileIsFree(tileId: 3) {
            buttonA3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        playerEndMove()
    }
    
    @IBAction func buttonB1Pressed(_ sender: Any) {
        if tileIsFree(tileId: 4) {
            buttonB1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        playerEndMove()
    }
    
    @IBAction func buttonB2Pressed(_ sender: Any) {
        if tileIsFree(tileId: 5) {
            buttonB2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        playerEndMove()
    }
    
    @IBAction func buttonB3Pressed(_ sender: Any) {
        if tileIsFree(tileId: 6) {
            buttonB3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        playerEndMove()
    }
    
    @IBAction func buttonC1Pressed(_ sender: Any) {
        if tileIsFree(tileId: 7) {
            buttonC1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        playerEndMove()
    }
    @IBAction func buttonC2Pressed(_ sender: Any) {
        if tileIsFree(tileId: 8) {
            buttonC2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        playerEndMove()
    }
    
    @IBAction func buttonC3Pressed(_ sender: Any) {
        if tileIsFree(tileId: 9) {
            buttonC3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
            tilesPlaced += 1
        }
        playerEndMove()
    }
    
    // MARK: - Screen UI config
    
    func configureScreen() {
        // Buttons setup
        setDefaultImagesForButtons()
        
        // Set corner radius for game
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 15
        
        // Set corner radius for gameView
        gameView.layer.cornerRadius = 15
    }
    
    func setTurnLabel(currentPlayer: String) {
        turnLabel.text = "Player \(currentPlayer)’s Turn"
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
