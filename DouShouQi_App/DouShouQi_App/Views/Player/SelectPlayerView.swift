//
//  SelectPlayerView.swift
//  DouShouQi_App
//
//  Created by nathan on 23/05/2024.
//

import SwiftUI
import SpriteKit
import DouShouQiModel

struct SelectPlayerView: View {
    
    @StateObject var player1 = PlayerVM()
    @StateObject var player2 = PlayerVM()
    
    @Binding var isDisplayed: Bool
    
    @State var gameIsPlaying: Bool = false
    @State var gameSettings: Bool = false
    
    var body: some View {
        VStack {
            TitlePageFrame(Text: "select players")
            
            Spacer()
            
            SelectPlayerButtonView(player1: player1, player2: player2, playersVM: PlayersVM())

            Spacer()
            
            HStack {
                VStack(alignment: .trailing)
                {
                    MainMenuButton(text: "Start", sound: "Start", onClick: {gameIsPlaying = true}, horizontalAlignment: .trailing, topLeftCorner: 10, bottomLeftCorner: 10)
                    MainMenuButton(text: "Settings", sound: "TitleScreenButtonSound", onClick: { gameSettings = true }, horizontalAlignment: .trailing, topLeftCorner: 10, bottomLeftCorner: 10)

                }
                .navigationDestination(isPresented: $gameIsPlaying) {
                    GameView(gameVM: PlayingGameVM(withRules: ClassicRules(), andPlayer1: HumanPlayer(withName: player1.player.name, andId: .player1)!, andPlayer2: HumanPlayer(withName: player2.player.name, andId: .player2)!)!,isDisplayed: $gameIsPlaying, parentIsDisplayed: $isDisplayed)
                }
                .navigationDestination(isPresented: $gameSettings) {
                    ContentView()
                }
            }
            
            Spacer()
        }
        .onAppear {
            playSound(named: "SelectFighterSound")
            
            //MusicPlayer.shared.playBackgroundMusic(music: "GameMusic")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                MusicPlayer.shared.playBackgroundMusic(music: "TitleScreenMusic")
            }
        }
        .onDisappear {
            MusicPlayer.shared.stopBackgroundMusic()
        }
    }
}

/*struct SelectPlayerViewPreviews: PreviewProvider {
    static var previews: some View {
        SelectPlayerView()
    }
}*/
