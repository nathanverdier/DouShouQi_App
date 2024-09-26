//
//  GameScene.swift
//  DouShouQi_App
//
//  Created by Nathan Verdier on 28/05/2024.
//

import Foundation
import SwiftUI
import SpriteKit
import DouShouQiModel

class GameScene : SKScene {
    
    var player1: DouShouQiModel.Player?
    var player2: DouShouQiModel.Player?
    
    var game: Game?
    
    let pieces: [Owner : [Animal:SpriteMeeple]] = [
        .player1: [
            .rat: SpriteMeeple(imageNamed: AppImages.Rat, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP1!, imageRotation: 180),
            .cat: SpriteMeeple(imageNamed: AppImages.Cat, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP1!, imageRotation: 180),
            .dog: SpriteMeeple(imageNamed: AppImages.Dog, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP1!, imageRotation: 180),
            .wolf: SpriteMeeple(imageNamed: AppImages.Wolf, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP1!, imageRotation: 180),
            .leopard: SpriteMeeple(imageNamed: AppImages.Leopard, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP1!, imageRotation: 180),
            .lion: SpriteMeeple(imageNamed: AppImages.Lion, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP1!, imageRotation: 180),
            .tiger: SpriteMeeple(imageNamed: AppImages.Tigger, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP1!, imageRotation: 180),
            .elephant: SpriteMeeple(imageNamed: AppImages.Elephant, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP1!, imageRotation: 180),
        ],
        .player2: [
            .rat: SpriteMeeple(imageNamed: AppImages.Rat, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP2!),
            .cat: SpriteMeeple(imageNamed: AppImages.Cat, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP2!),
            .dog: SpriteMeeple(imageNamed: AppImages.Dog, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP2!),
            .wolf: SpriteMeeple(imageNamed: AppImages.Wolf, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP2!),
            .leopard: SpriteMeeple(imageNamed: AppImages.Leopard, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP2!),
            .lion: SpriteMeeple(imageNamed: AppImages.Lion, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP2!),
            .tiger: SpriteMeeple(imageNamed: AppImages.Tigger, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP2!),
            .elephant: SpriteMeeple(imageNamed: AppImages.Elephant, size: CGSize(width: 100, height: 100), backgroundColor: Colors.MeepleP2!),
        ],
    ]
    
    let imageBoard: SKSpriteNode = SKSpriteNode(imageNamed: AppImages.boardGame)
    
    override init(size: CGSize) {
        super.init(size: size)
        imageBoard.size = size
        //self.scaleMode = .aspectFit
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = .white
        
        self.addChild(imageBoard)
    }
    
    convenience init(size: CGSize, gameVM: PlayingGameVM) {
        self.init(size: size)
        self.game = gameVM.game
        self.player1 = self.game?.players[.player1]
        self.player2 = self.game?.players[.player2]
        
        for piece in pieces.flatMap({owner, pieces in pieces.values}) {
            self.addChild(piece)
            piece.setOnMove(onMove: gameVM.onMeepleMove)
        }
        
        initializeBoard(game!.board)
        
        gameVM.game.addPieceRemovedListener { _, _, piece in
            self.pieces[piece.owner]![piece.animal]?.removeFromParent()
        }
        
        gameVM.start()
    }
    
    func initializeBoard(_ board: Board) {
        for (lineIndex, currentLine) in game!.board.grid.enumerated() {
            for (cellIndex, currentCell) in currentLine.enumerated() {
                if let piece = currentCell.piece {
                    pieces[piece.owner]?[piece.animal]?.cellPosition = CGPoint(x: cellIndex, y: lineIndex)
                    pieces[piece.owner]?[piece.animal]?.cellPosition = CGPoint(x: 0, y: 0)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        game = try! Game(withRules: ClassicRules(), andPlayer1: DouShouQiModel.Player(withName: "P1", andId: .player1)!, andPlayer2: DouShouQiModel.Player(withName: "P2", andId: .player2)!)
        super.init(coder: aDecoder);
    }
}
