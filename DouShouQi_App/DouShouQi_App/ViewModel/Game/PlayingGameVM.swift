//
//  PlayingGameVM.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 21/06/2024.
//

import Foundation
import SwiftUI
import DouShouQiModel

class PlayingGameVM: ObservableObject {
    
    // Properties
    @Published var game: Game
    
    // Computed properties
    public var currentPlayerName: String { game.players[game.rules.getNextPlayer()]?.name ?? (game.rules.getNextPlayer() == .player1 ? "P1" : "P2") }
    
    public var lastMove: String {
        if let move: Move = game.rules.historic.last {
            return "\(move.columnDestination).\(move.rowDestination)"
        }
        else {
            return ""
        }
    }
    
    public var lastPieceMoved: String {
        if let move: Move = game.rules.historic.last {
            return game.board.grid[move.rowDestination][move.columnDestination].piece?.animal.symbol ?? ""
        } else {
            return ""
        }
    }
    
    public var currentPlayerColor: UIColor {
        return game.rules.getNextPlayer() == .player1 ? Colors.MeepleP1! : Colors.MeepleP2!
    }
    
    public var winner: String {
        guard self.game.isOver else {
            return ""
        }

        guard let lastMove: Move = self.game.rules.historic.last else {
            return ""
        }
        
        guard let winner: DouShouQiModel.Player = game.players[lastMove.owner] else {
            return ""
        }
        return winner.name
    }
    
    // Inits
    init(withGame game: Game) {
        self.game = game
    }
    
    init?(withRules rules: Rules, andPlayer1 p1: DouShouQiModel.Player, andPlayer2 p2: DouShouQiModel.Player) {
        do {
            self.game = try Game(withRules: rules, andPlayer1: p1, andPlayer2: p2)
            
            self.game.addInvalidMoveCallbacksListener { _, move, player, result in
                if result {
                    return
                }
                print("**************************************")
                print("⚠️⚠️⚠️⚠️ Invalid Move detected: \(move) by \(player.name) (\(player.id))")
                print("**************************************")
               
            }
            
            self.game.addGameOverListener { board, result, player in
                switch(result){
                case .notFinished:
                    print("⏳ Game is not over yet!")
                case .winner(winner: let o, reason: let r):
                    print(board)
                    print("**************************************")
                    print("Game Over!!!")
                    print("🥇🏆 and the winner is... \(o == .player1 ? "🟡" : "🔴") \(player?.name ?? "")!")
                    switch(r){
                        case .denReached:
                            print("🪺 the opponent's den has been reached.")
                        case .noMorePieces:
                            print("🐭🐱🐯🦁🐘 all the opponent's animals have been eaten...")
                        case .noMovesLeft:
                            print("⛔️ the opponent can not move any piece!")
                        case .tooManyOccurences:
                            print("🔄 the opponent seem to like this situation... but enough is enough. Sorry...")
                        default:
                            print("Reason unknown...")
                    }
                    print("**************************************")
                default:
                    break
                }

            }
            
        } catch {
            print("Error")
            return nil
        }
    }
    
    // Customs funcs
    func onMeepleMove(_ sender: SpriteMeeple, _ start: CGPoint, _ end: CGPoint) {
        let owner = game.rules.getNextPlayer()
        let player: DouShouQiModel.Player = game.players[owner]!
        
        let move = Move(of: owner, fromRow: Int(start.y), andFromColumn: Int(start.x), toRow: Int(end.y), andToColumn: Int(end.x))
        
        if (game.rules.isMoveValid(onBoard: game.board, withMove: move)) {
            print("Meeple moved = ", start, " -> ", end)
            
            Task {
                try! await (player as! HumanPlayer).chooseMove(move)
            }
            self.objectWillChange.send()
        } else {
            sender.cellPosition = start
            sender.cellPosition = start
        }
        
    }
    
    public func start() {
        Task {
            try await self.game.start()
        }
    }
    
}
