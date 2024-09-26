import SwiftUI
import SpriteKit
import DouShouQiModel

struct GameView: View {
    
    @StateObject var gameVM: PlayingGameVM
    @StateObject var chronoVM = ChronometerViewModel()
    
    @Binding var isDisplayed: Bool
    @Binding var parentIsDisplayed: Bool
    
    @StateObject var historicVm = HistoricListVM()
    
    var body: some View {
        ZStack {
            VStack {
                TopGameBoard(gameVM: gameVM, chronoVM: chronoVM).frame(maxHeight: 200)
                SpriteView(scene: GameScene(size: CGSize(width: 700, height: 900), gameVM: gameVM))
            }
            .onAppear {
                playSound(named: "Fight")
                chronoVM.startTimer()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    MusicPlayer.shared.playBackgroundMusic(music: "GameMusic")
                }
            }
            .onDisappear {
                MusicPlayer.shared.stopBackgroundMusic()
            }
            
            if gameVM.game.isOver {
                VStack(spacing: 20) {
                    Text("Game Over")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Winner: \(gameVM.winner)")
                        .font(.title2)
                }
                .padding()
                .background(Colors.WinnerBackground)
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding()
                .onAppear {
                    chronoVM.stopTimer()
                    saveHistoric()
                    Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
                        
                        isDisplayed = false
                        parentIsDisplayed = false
                    }
                }
            }
        }
        .onDisappear {
            MusicPlayer.shared.stopBackgroundMusic()
        }
        .navigationBarHidden(true)
    }
    
    private func saveHistoric() {
        let player1_name = gameVM.game.players[.player1]?.name
        let player2_name = gameVM.game.players[.player2]?.name
        let newHistoric = HistoricVM(historic: Historique(player1_name: player1_name ?? "", player2_name: player2_name ?? "", time: chronoVM.formattedTime(), result: gameVM.winner))
        historicVm.SavePlayer(historic: newHistoric)
    }
}
