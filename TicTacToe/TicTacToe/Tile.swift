//
//  Tile.swift
//  TicTacToe
//
//  Created by Paweł Brzozowski on 15/12/2021.
//

import Foundation

struct Tile {
    // Id represent number from top left corner to bottom right (1-9)
    var id: Int?
    // Is it X or O or meybe nil
    var occupiedBy: String?
}
