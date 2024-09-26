//
//   SoundPlayer.swift
//  DouShouQi_App
//
//  Created by Nathan Verdier on 27/05/2024.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(named soundName: String) {
    guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }

    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    } catch let error {
        print("Error playing sound. \(error.localizedDescription)")
    }
}
