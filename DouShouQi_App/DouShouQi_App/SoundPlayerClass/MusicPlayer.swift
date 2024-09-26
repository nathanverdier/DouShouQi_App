//
//   MusicPlayer.swift
//  DouShouQi_App
//
//  Created by Nathan Verdier on 27/05/2024.
//

import Foundation
import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?

    func playBackgroundMusic(music: String) {
        if let bundle = Bundle.main.path(forResource: music, ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }

    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}
