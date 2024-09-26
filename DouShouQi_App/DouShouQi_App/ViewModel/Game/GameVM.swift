//
//  GameVM.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 29/05/2024.
//

import Foundation
import SwiftUI
import DouShouQiModel

class GameVM: ObservableObject, Identifiable {
    // Properties
    var game: Game
    
    // Computed Properties
    public var player1Name: String {
        return game.players[.player1]?.name ?? "P1"
    }
    
    public var player2Name: String {
        return game.players[.player2]?.name ?? "P2"
    }
    
    public var gameStatus: String {
        if let lastMove = game.rules.historic.last {
            let (_, result) = game.rules.isGameOver(withBoard: game.board,
                                                           andLastRowPlayed: lastMove.rowDestination,
                                                           andLastColumnPlayer: lastMove.columnDestination)
            switch result {
                case .notFinished:
                    return "Not Finished"
                case .even:
                    return "Draw"
                case .winner(let winningPlayer, _):
                    return "Winner: \(winningPlayer)"
                    
                @unknown default:
                    return "Not Started"
            }
        } else {
            return "Not Started"
        }
    }
    
    // Init
    init(withGame game: Game, time: String) {
        self.game = game
    }
}
