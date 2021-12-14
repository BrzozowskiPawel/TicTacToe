//
//  ViewController.swift
//  TicTacToe
//
//  Created by Paweł Brzozowski on 14/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundGradientView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setBacgroundGradient()
        
    }

    func setBacgroundGradient() {
        // Create a gradient layer.
        let gradientLayer = CAGradientLayer()
        // Set the size of the layer to be equal to size of the display.
        gradientLayer.frame = view.bounds
        // Set an array of Core Graphics colors (.cgColor) to create the gradient.
        let firstColor = UIColor(red: 0/255, green: 210/255, blue: 255/255, alpha: 1).cgColor
        let secondColor = UIColor(red: 58/255, green: 123/255, blue: 213/255, alpha: 1).cgColor
        gradientLayer.colors = [ firstColor, secondColor]
        // Rasterize this static layer to improve app performance.
        gradientLayer.shouldRasterize = true
        // Apply the gradient to the backgroundGradientView.
        backgroundGradientView.layer.addSublayer(gradientLayer)
    }
}

