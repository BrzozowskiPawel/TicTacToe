//
//  GameOverViewController.swift
//  TicTacToe
//
//  Created by Paweł Brzozowski on 16/12/2021.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var labelImage: UILabel!
    @IBOutlet weak var GameOverView: UIView!
    
    var playerHasWon: Bool?
    var popUpTimer: Timer?
    var secondsToClosePopUp = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set corner radius for gameView
        GameOverView.layer.cornerRadius = 15

        // Defaulty user won, other casechange apperance
        if !playerHasWon! {
            userHasLost()
        }
        
    }
    
    @objc func popUpTimerStarted() {
        // Decrement the counter
        secondsToClosePopUp -= 1
    
        // Stop the timer if it reaches zero
        if secondsToClosePopUp == 1 {
            popUpTimer?.invalidate()
            dismiss(animated: true, completion: nil)
        }
    }
    
    func userHasLost() {
        mainLabel.text = "OH NOOOOOO"
        secondLabel.text = "YOU HAVE LOST"
        secondLabel.textColor = UIColor.red
        labelImage.text = "😭"
    }
    

    
}
