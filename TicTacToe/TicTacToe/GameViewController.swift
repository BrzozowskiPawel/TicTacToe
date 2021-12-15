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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    func TileIsFree(tileId: Int) -> Bool{
        if occupiedTiles[tileId] == "" {
            occupiedTiles[tileId] = self.playerType!
            return true
        } else {
            print("Sorry already occupied by: \(occupiedTiles[tileId]!)")
            return false
        }
    }
    
    
    @IBAction func buttonA1Pressed(_ sender: Any) {
        if TileIsFree(tileId: 1) {
            buttonA1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
        }
        
    }
    
    @IBAction func buttonA2Pressed(_ sender: Any) {
        if TileIsFree(tileId: 2) {
            buttonA2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
        }
    }
    
    @IBAction func buttonA3Pressed(_ sender: Any) {
        if TileIsFree(tileId: 3) {
            buttonA3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
        }
    }
    
    @IBAction func buttonB1Pressed(_ sender: Any) {
        if TileIsFree(tileId: 4) {
            buttonB1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
        }
    }
    
    @IBAction func buttonB2Pressed(_ sender: Any) {
        if TileIsFree(tileId: 5) {
            buttonB2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
        }
    }
    
    @IBAction func buttonB3Pressed(_ sender: Any) {
        if TileIsFree(tileId: 6) {
            buttonB3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
        }
    }
    
    @IBAction func buttonC1Pressed(_ sender: Any) {
        if TileIsFree(tileId: 7) {
            buttonC1.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
        }
    }
    @IBAction func buttonC2Pressed(_ sender: Any) {
        if TileIsFree(tileId: 8) {
            buttonC2.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
        }
    }
    
    @IBAction func buttonC3Pressed(_ sender: Any) {
        if TileIsFree(tileId: 9) {
            buttonC3.setImage(UIImage(named: "\(self.playerType!)_SPACE.png"), for: .normal)
        }
    }
    
    
}
