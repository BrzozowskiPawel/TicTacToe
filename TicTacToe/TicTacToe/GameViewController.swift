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
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureScreen()
    }
    
    func configureScreen() {
        // Setup the buttons FIRST ROW
        buttonA1.setImage(UIImage(named: "X_SPACE.png"), for: .normal)
        buttonA1.setTitle("", for: .normal)
        buttonA2.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonA2.setTitle("", for: .normal)
        buttonA3.setImage(UIImage(named: "O_SPACE.png"), for: .normal)
        buttonA3.setTitle("", for: .normal)
        
        // Setup the buttons SECOND ROW
        buttonB1.setImage(UIImage(named: "X_SPACE.png"), for: .normal)
        buttonB1.setTitle("", for: .normal)
        buttonB2.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonB2.setTitle("", for: .normal)
        buttonB3.setImage(UIImage(named: "O_SPACE.png"), for: .normal)
        buttonB3.setTitle("", for: .normal)
        
        // Setup the buttons THIRD ROW
        buttonC1.setImage(UIImage(named: "X_SPACE.png"), for: .normal)
        buttonC1.setTitle("", for: .normal)
        buttonC2.setImage(UIImage(named: "DEFAULT_SPACE.png"), for: .normal)
        buttonC2.setTitle("", for: .normal)
        buttonC3.setImage(UIImage(named: "O_SPACE.png"), for: .normal)
        buttonC3.setTitle("", for: .normal)
        
        // Set corner radius for game
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 15
        
        // Set corner radius for gameView
        gameView.layer.cornerRadius = 15
    }
    

}
