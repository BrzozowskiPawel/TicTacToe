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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set corner radius for gameView
        GameOverView.layer.cornerRadius = 15

    }

    // Hide NavigationController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
