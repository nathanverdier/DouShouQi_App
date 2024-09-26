//
//  Language.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 04/06/2024.
//

import Foundation

public enum Language: String, Identifiable {
        
    case french, english, spanish
    
    public var id: String {
        return self.rawValue
    }
    
    public var litteral: String {
        switch self {
            case .french:
                return "Français"
            case .english:
                return "English"
            case .spanish:
                return "Español"
        }
    }
    
    static var list: [Language] {
        return [.french, .english, .spanish]
    }
}
