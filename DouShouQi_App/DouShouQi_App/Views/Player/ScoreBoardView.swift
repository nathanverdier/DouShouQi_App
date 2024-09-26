import SwiftUI
import DouShouQiModel

struct ScoreBoardView: View {
    @State private var topPlayers: [PlayerVM] = []
    
    var body: some View {
        VStack {
            HStack {
                TitlePageFrame(Text: "Score Board", ImageWidth: 200, ImageHeight: 200)
            }
            
            VStack {
                HStack {
                    Text("Rank")
                        .font(.headline)
                        .frame(width: 50, alignment: .trailing)
                    
                    Text("Name")
                    
                    Spacer()
                    
                    Text("Wins")
                        .frame(width: 55, alignment: .trailing)
                    
                    Text("Looses")
                        .frame(width: 55, alignment: .trailing)
                    
                }
                .padding(10)
                
                HStack {
                    Rectangle()
                        .frame(height: 2)
                }
                
                ForEach(topPlayers.indices, id: \.self) { index in
                    let player = topPlayers[index]
                    PlayerScoreResumeFrame(
                        Name: player.player.name,
                        Rank: index + 1,
                        Wins: player.win,
                        Looses: player.loose
                    )
                }
            }
            
            Spacer()
        }
        .padding(10)
        .onAppear {
            topPlayers = PlayersVM.fetchTopPlayers()
        }
    }
}

struct ScoreBoardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBoardView()
    }
}
