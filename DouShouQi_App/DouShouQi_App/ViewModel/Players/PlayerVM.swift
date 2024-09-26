//
//  PlayerExtension.swift
//  DouShouQi_App
//
//  Created by étudiant on 04/06/2024.
//

import Foundation
import DouShouQiModel

public class PlayerVM: ObservableObject, Identifiable, Hashable{
    public static func == (lhs: PlayerVM, rhs: PlayerVM) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @Published var player: Player
    var loose: Int {
        return CoreDataManager.shared.countDefeats(for: player.name)
    }
    
    var win: Int {
        return CoreDataManager.shared.countVictories(for: player.name)
    }
    
    var rank: Int {
        let allPlayers = CoreDataManager.shared.fetchPlayers()
        let allPlayerVMs = allPlayers.map { PlayerVM(player: $0.toModel()) }
        
        let sortedPlayers = allPlayerVMs.sorted { $0.win > $1.win }
        if let rankIndex = sortedPlayers.firstIndex(where: { $0.player.name == self.player.name }) {
            return rankIndex + 1
        }
        return 0
    }
    
    
    //public func getPlayer(name: String): PlayerVM{}
    
    
    init(player: Player) {
        self.player = player
    }
    
    convenience init() {
        self.init(player: Player(name: "IA", photo: ""))
    }
    
}

