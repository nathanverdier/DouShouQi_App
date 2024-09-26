//
//  ShowAllPlayer.swift
//  DouShouQi_App
//
//  Created by Nathan Verdier on 14/06/2024.
//

import SwiftUI

struct ShowAllPlayer: View {
    @State private var isShowingSheet = false
    @Binding var currentShowingSheet: Bool
    
    @ObservedObject var currentPlayer: PlayerVM
    @ObservedObject var otherPlayer: PlayerVM
    @ObservedObject var playersVM: PlayersVM

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Choose a player:")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top, 20)

            List {
                ForEach($playersVM.players, id: \.self) { playerVM in
                    if otherPlayer.player.name != playerVM.player.wrappedValue.name {
                        Button(action: {
                            if currentPlayer.player.name == playerVM.player.wrappedValue.name {
                                currentPlayer.player = Player(name: "IA", photo: "")
                            } else {
                                currentPlayer.player = playerVM.player.wrappedValue
                            }
                            self.currentShowingSheet = false
                        }) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.blue)
                                    .padding(.trailing, 10)
                                Text(playerVM.player.name.wrappedValue)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                if currentPlayer.player.name == playerVM.player.wrappedValue.name {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())

            Button(action: {
                self.isShowingSheet = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                    Text("Add a player")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
            .sheet(isPresented: $isShowingSheet) {
                AddPlayerView(isPresented: $isShowingSheet, playersVM: playersVM)
            }
        }
        .background(Color(.systemGroupedBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

