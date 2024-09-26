//
//  ARKitViewRepresentable.swift
//  DouShouQi_App
//
//  Created by etudiant on 24/06/2024.
//

import SwiftUI
import ARKit
import RealityKit
import DouShouQiModel

class ARKitView: ARView {
    
    @ObservedObject var playingGameVM: PlayingGameVM
    
    required init(frame frameRect: CGRect) {
        self.playingGameVM = PlayingGameVM(withRules: ClassicRules(), andPlayer1: HumanPlayer(withName: "Player 1", andId: .player1)!, andPlayer2: HumanPlayer(withName: "Player 2", andId: .player2)!)!
        super.init(frame: frameRect)
    }
    
    @MainActor required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    convenience init(playingGameVM: PlayingGameVM, imageBoard: String = "board", cell_size: Float = 0.1145) {
        self.init(frame: UIScreen.main.bounds)
        self.playingGameVM = playingGameVM
        initBoard(withBoard: playingGameVM.game.board, andImage: imageBoard)
    }
    
    func applyConfiguration() {
        let conf = ARWorldTrackingConfiguration()
        self.session.run(conf)
    }
    
    func initBoard(withBoard board: Board, andImage image: String) {
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(1, 1)))
        let arBoard = ARBoard(image: image)
        anchor.addChild(arBoard)
        self.scene.addAnchor(anchor)
        arBoard.setPosition(SIMD3(x: 0, y: 0, z: 0), relativeTo: anchor)
    }
}
