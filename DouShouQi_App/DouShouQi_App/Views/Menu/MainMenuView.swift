//
//  MainMenuView.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 16/05/2024.
//

import SwiftUI
import DouShouQiModel

struct MainMenuView: View {
    
    @State private var showSplash = true
    @State private var currentImage: String?
    @State private var timer: Timer?
    @State private var showImage = false
    
    @State var showSelectPlayer = false
    @State var showHistoric = false
    @State var showBestScores = false
    @State var showPlayers = false
    @State var showSettings = false
    @State var showARKit = false
    
    @StateObject var historicList = HistoricListVM()
    
    let images: [String] = [AppImages.SemiLion, AppImages.SemiDog, AppImages.SemiRat, AppImages.SemiWolf, AppImages.SemiLeopard, AppImages.SemiElephant, AppImages.SemiCat] // Add your image names here
    
    var body: some View {
        NavigationStack {
            VStack {
                if showSplash {
                    SplashScreenView()
                        .transition(.opacity)
                        .animation(.easeOut(duration: 3), value: showSplash)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                                withAnimation {
                                    showSplash = false
                                }
                            }
                        }
                } else {
                    TitlePageFrame(Text: "DOU SHOU QI", ImageWidth: 200, ImageHeight: 200)
                    Spacer()
                    
                    VStack {
                        HStack {
                            VStack(spacing: 25) {
                                MainMenuButton(text: "Play", sound: "TitleScreenButtonSound",onClick: { showSelectPlayer = true }, topRightCorner: 10, bottomRightCorner: 10)
                                MainMenuButton(text: "Historique", sound: "TitleScreenButtonSound",onClick: { showHistoric = true }, topRightCorner: 10, bottomRightCorner: 10)
                                MainMenuButton(text: "Best Scores", sound: "TitleScreenButtonSound",onClick: { showBestScores = true }, topRightCorner: 10, bottomRightCorner: 10)
                                MainMenuButton(text: "Players", sound: "TitleScreenButtonSound",onClick: { showPlayers = true }, topRightCorner: 10, bottomRightCorner: 10)
                                MainMenuButton(text: "Settings", sound: "TitleScreenButtonSound",onClick: { showSettings = true }, topRightCorner: 10, bottomRightCorner: 10)
                                MainMenuButton(text: "AR Kit Version", sound: "TitleScreenButtonSound", onClick: { showARKit = true }, topRightCorner: 10, bottomRightCorner: 10)
                            }
                            .navigationDestination(isPresented: $showSelectPlayer) {
                                SelectPlayerView(isDisplayed: $showSelectPlayer)
                            }
                            .navigationDestination(isPresented: $showHistoric) {
                                HistoricView(historicListVM: historicList)
                            }
                            .navigationDestination(isPresented: $showBestScores) {
                                ScoreBoardView()
                            }
                            .navigationDestination(isPresented: $showPlayers) {
                                PlayersView()
                            }
                            .navigationDestination(isPresented: $showSettings) {
                                SettingsView()
                            }
                            .navigationDestination(isPresented: $showARKit) {
                                ARKitUIViewRepresentable(aRKitView: ARKitView(playingGameVM: PlayingGameVM(withRules: ClassicRules(), andPlayer1: HumanPlayer(withName: "Player 1", andId: .player1)!, andPlayer2: HumanPlayer(withName: "Player 2", andId: .player2)!)!))
                            }
                            
                            if let currentImage = currentImage {
                                Image(currentImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 500)
                                    .transition(.opacity)
                                    .animation(.easeInOut(duration: 1), value: showImage)
                                    .onAppear {
                                        withAnimation {
                                            showImage = true
                                        }
                                    }
                            }
                        }
                    }
                    Spacer()
                    HStack {
                        Text("Copyright @")
                            .font(.headline)
                            .frame(alignment: .trailing)
                        
                        Text("Dou Shou Qi Team")
                        
                        Spacer()
                        
                        Text("2024")
                            .frame(alignment: .trailing)
                    }
                    .padding()
                    .overlay(
                        Rectangle()
                            .stroke(Colors.TitleText, lineWidth: 1)
                    )
                    
                    Spacer()
                        .onAppear {
                            startTimer()
                            MusicPlayer.shared.playBackgroundMusic(music: "TitleScreenMusic")
                        }
                        .onDisappear {
                            stopTimer()
                            MusicPlayer.shared.stopBackgroundMusic()
                        }
                }
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            changeImage()
        }
        changeImage() // Immediately change the image on appear
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func changeImage() {
        DispatchQueue.main.async {
            currentImage = images.randomElement()
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
