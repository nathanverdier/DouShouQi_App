//
//  DouShouQi_AppApp.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 16/05/2024.
//

import SwiftUI


@main
struct DouShouQi_AppApp: App {
    // Create an instance of SettingsVM
    @StateObject private var settingsVM = SettingsVM()
    
    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .environmentObject(settingsVM)
        }
    }
}
