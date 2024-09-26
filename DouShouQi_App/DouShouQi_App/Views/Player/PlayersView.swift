//
//  PlayersView.swift
//  DouShouQi_App
//
//  Created by étudiant on 26/05/2024.
//

import Foundation
import SwiftUI

struct PlayersView: View {
    
    @StateObject var playersVM = PlayersVM()
    @State var searchText = ""
    @State var showingPopup = false
    @State var newPlayerName = ""
    
    var filteredPlayers: [PlayerVM] {
        if searchText.isEmpty {
            return playersVM.players
        } else {
            return playersVM.players.filter { $0.player.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var groupedPlayers: [String: [PlayerVM]] {
        Dictionary(grouping: filteredPlayers) { player in
            String(player.player.name.prefix(1)).uppercased()
        }
    }
    
    public var body: some View {
        NavigationStack {
            VStack {
                TitlePageFrame(Text: "PLAYERS", ImageWidth: 200, ImageHeight: 200)
                
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                
                List {
                    ForEach(groupedPlayers.keys.sorted(), id: \.self) { key in
                        Section(header: Text(key)) {
                            ForEach(groupedPlayers[key]!, id: \.self) { player in
                                PlayerRow(player: player, players: playersVM)
                            }
                        }
                    }
                }
                
                Button(action: {
                    showingPopup = true
                }) {
                    Text("Add a player")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom)
                .sheet(isPresented: $showingPopup) {
                    AddPlayerView(isPresented: $showingPopup, playersVM: playersVM)
                }
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView(playersVM: PlayersVM())
    }
}
