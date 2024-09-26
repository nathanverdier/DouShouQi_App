//
//  Animals.Symbols.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 21/06/2024.
//

import Foundation
import DouShouQiModel

extension Animal {
    public var symbol: String {
        switch self{
        case .rat:
            return "🐭"
        case .cat:
            return "🐱"
        case .dog:
            return "🐶"
        case .wolf:
            return "🐺"
        case .leopard:
            return "🐆"
        case .tiger:
            return "🐯"
        case .lion:
            return "🦁"
        case .elephant:
            return "🐘"
        @unknown default:
            return "🐥"
        }
    }
}
