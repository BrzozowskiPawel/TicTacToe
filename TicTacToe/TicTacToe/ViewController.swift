//
//  ViewController.swift
//  TicTacToe
//
//  Created by Paweł Brzozowski on 14/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var oButton: UIButton!
    
    var choosenType: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Setup the buttons
        xButton.setImage(UIImage(named: "x_button.png"), for: .normal)
        xButton.setTitle("", for: .normal)
        oButton.setImage(UIImage(named: "o_button.png"), for: .normal)
        oButton.setTitle("", for: .normal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameVC = segue.destination as? GameViewController {
            gameVC.playerType = self.choosenType
        }
    }
    
    @IBAction func xButtonPressed(_ sender: UIButton) {
        print("x button pressed")
        self.choosenType = "X"
        goToGameVC()
    }
    
    @IBAction func oButtonPressed(_ sender: UIButton) {
        print("o button pressed")
        self.choosenType = "O"
        goToGameVC()
    }
    
    func goToGameVC() {
        performSegue(withIdentifier: "gameSegue", sender: nil)
    }
    
}

