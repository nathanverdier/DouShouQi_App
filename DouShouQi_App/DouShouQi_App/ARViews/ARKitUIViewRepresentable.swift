//
//  ARKitUIViewBoard.swift
//  DouShouQi_App
//
//  Created by etudiant on 24/06/2024.
//

import SwiftUI
import DouShouQiModel
import ARKit
import RealityKit

struct ARKitUIViewRepresentable: UIViewRepresentable {
    
    var aRKitView: ARKitView
    
    func makeUIView(context: Context) -> ARKitView {
        return aRKitView
    }

    func updateUIView(_ uiView: ARKitView, context: Context) {}
}

