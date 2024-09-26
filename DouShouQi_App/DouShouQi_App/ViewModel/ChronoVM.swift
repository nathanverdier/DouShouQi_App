//
//  ChronoVM.swift
//  DouShouQi_App
//
//  Created by étudiant on 24/06/2024.
//

import SwiftUI
import Combine

class ChronometerViewModel: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    private var timer: AnyCancellable?
    
    func startTimer() {
        let startDate = Date()
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
            self.elapsedTime = Date().timeIntervalSince(startDate)
        }
    }
    
    func stopTimer() {
        timer?.cancel()
    }
    
    func formattedTime() -> String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

