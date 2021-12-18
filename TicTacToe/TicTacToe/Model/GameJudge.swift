//
//  GameJudge.swift
//  TicTacToe
//
//  Created by Paweł Brzozowski on 18/12/2021.
//

import Foundation

struct GameJudge {
//    public func gameOver(winserType: String, tilesPlaced: Int, occupiedTiles: [Int: String]) -> Bool{
//        if checkForWinInRows(winerType: winserType, occupiedTiles: occupiedTiles) {
//            return true
//        } else if checkForWinInColumns(winerType: winserType, occupiedTiles: occupiedTiles) {
//            return true
//        } else if checkForWinInDiagonals(winerType: winserType, occupiedTiles: occupiedTiles) {
//            return true
//        } else {
//            if tilesPlaced == 9 {
//                self.draft = true
//                goToGameOverVC()
//                timer?.invalidate()
//            }
//            return false
//        }
//    }
    
    static func checkForWinInRows(winerType: String, occupiedTiles: [Int: String]) -> Bool{
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
    
    static func checkForWinInColumns(winerType: String, occupiedTiles: [Int: String]) -> Bool{
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
    
    static func checkForWinInDiagonals(winerType: String, occupiedTiles: [Int: String]) -> Bool{
        if occupiedTiles[1] == winerType && occupiedTiles[5] == winerType && occupiedTiles[9] == winerType {
            return true
        } else if occupiedTiles[3] == winerType && occupiedTiles[5] == winerType && occupiedTiles[7] == winerType {
            return true
        } else {
            return false
        }
    }
}
