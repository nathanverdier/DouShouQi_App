import Foundation
import SwiftUI

struct PlayerRow: View {
    @ObservedObject var player: PlayerVM
    @State private var showDetailView = false
    @ObservedObject var players: PlayersVM

 
    var body: some View {
        HStack {
            if let image = UIImage(contentsOfFile: player.player.photo) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading) {
                Text(player.player.name)
                    .font(.headline)
                Text("Victoires : \(player.win)  Défaites : \(player.loose)")
                    .font(.subheadline)
            }
            Spacer()
            HStack(spacing: 10) {
                Button(action: {
                    showDetailView.toggle()
                }) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $showDetailView) {
                    PlayerStatView(player: player, players: players, showDetailView: $showDetailView)
                        .presentationDetents([.medium, .large])
                }
            }
        }
        .padding()
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}
