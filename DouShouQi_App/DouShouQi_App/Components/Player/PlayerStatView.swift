//
//  PlayerStatView.swift
//  DouShouQi_App
//
//  Created by étudiant on 31/05/2024.
//

import SwiftUI

struct PlayerStatView: View {
    @StateObject var player: PlayerVM
    @State private var showEditView = false
    @State private var showDeleteAlert = false
    @ObservedObject var players: PlayersVM
    @Binding var showDetailView: Bool
    var body: some View {
        VStack {
            if let image = UIImage(contentsOfFile: player.player.photo) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.top, 10)
            } else {
                Image(systemName: "person.circle.fill")

                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
                    .padding(.top, 10)
            }
            
            Text(player.player.name)
                .font(.largeTitle)
                .foregroundColor(Colors.TitleText)
                .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "trophy.fill")
                    Text("Win : \(player.win)")
                        .font(.title2)
                }
                HStack {
                    Image(systemName: "xmark.circle.fill")
                    Text("Loose : \(player.loose)")
                        .font(.title2)
                }
                HStack {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Win Rate : \(String(format: "%.2f", (Double(player.win) / Double(player.win + player.loose)) * 100))%")
                        .font(.title2)
                }
                HStack {
                    Image(systemName: "list.number")
                    Text("Rank : \(player.rank)")
                        .font(.title2)
                }
                
                
                HStack{
                    Button(action: {
                        showEditView.toggle()
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.green)
                    }
                    .sheet(isPresented: $showEditView) {
                        EditPlayerView(isPresented: $showEditView, player: player, playersVM: players, playerName: player.player.name)
                    }
                    
                    Button(action: {
                        showDeleteAlert.toggle()
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text("Delete Player"),
                            message: Text("Are you sure you want to delete this player?"),
                            primaryButton: .destructive(Text("Delete")) {
                                CoreDataManager.shared.deletePlayer(playerVM: player)
                                players.refreshPlayers()
                                showDetailView = false
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    
                }
                
            }
            .padding()
            Spacer()
        }
    }
}
