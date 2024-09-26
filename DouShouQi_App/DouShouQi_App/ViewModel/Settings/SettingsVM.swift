//
//  SettingsVM.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 30/05/2024.
//

import Foundation
import SwiftUI

class SettingsVM: ObservableObject {
    // Properties
    @Published var darkTheme: Bool = false
    @Published var language: Language = Language.english
    @Published var soundOn: Bool = true
    
    init() {}
}
