//
//  PlayersVM.swift
//  DouShouQi_App
//
//  Created by étudiant on 12/06/2024.
//

import Foundation
import DouShouQiModel
import CoreData
import Combine

public class PlayersVM: ObservableObject{
    
    @Published var players: [PlayerVM]
    
    public func SavePlayer(player: PlayerVM){
        players.append(player)
        CoreDataManager.shared.savePlayer(playerVM: player)
    }
    
    public func contains(where predicate: (PlayerVM) -> Bool) -> Bool {
        return players.contains(where: predicate)
    }
    
    
    public func getAllPlayer() -> [PlayerVM]{
        let coreDataPlayers = CoreDataManager.shared.fetchPlayers()
        self.players = coreDataPlayers.map { PlayerVM(player: $0.toModel()) }
        return players
    }
    
    func refreshPlayers() {
        let cdPlayers = CoreDataManager.shared.fetchPlayers()
        players = cdPlayers.map { PlayerVM(player: Player(name: $0.name ?? "", photo: $0.photo ?? "")) }
    }
    
    func updatePlayer(playerVM: PlayerVM, playerName: String) {
        if let index = players.firstIndex(where: { $0.player.name == playerName }) {
            players[index] = playerVM
            CoreDataManager.shared.saveContext()
            refreshPlayers()
        }
    }
    
    static func fetchTopPlayers(limit: Int = 10) -> [PlayerVM] {
        let players = CoreDataManager.shared.fetchPlayers().map { PlayerVM(player: $0.toModel()) }
        let sortedPlayers = players.sorted { $0.win > $1.win }
        return Array(sortedPlayers.prefix(limit))
    }
    
    init() {
        players = []
        
        players = getAllPlayer()
    }
    
}
