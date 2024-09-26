//
//  ARBoard.swift
//  DouShouQi_App
//
//  Created by Nathan Verdier on 24/06/2024.
//

import RealityKit

class ARBoard: Entity {
    
    required init(image: String) {
        super.init()
        if let boardEntity = try? Entity.loadModel(named: image) {
            self.addChild(boardEntity)
        }
    }
    
    @MainActor required init() {
        fatalError("init() has not been implemented")
    }
}
