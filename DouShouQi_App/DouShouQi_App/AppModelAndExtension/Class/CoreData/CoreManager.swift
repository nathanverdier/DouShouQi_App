//
//  CoreManger.swift
//  DouShouQi_App
//
//  Created by étudiant on 14/06/2024.
//

import Foundation
import CoreData
import DouShouQiModel
import Combine

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DouShouQi_App")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func savePlayer(playerVM: PlayerVM) {
        let player = CDPlayer(context: context)
        player.name = playerVM.player.name
        player.photo = playerVM.player.photo
        saveContext()
    }

    func fetchPlayers() -> [CDPlayer] {
        let fetchRequest: NSFetchRequest<CDPlayer> = CDPlayer.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch players: \(error)")
            return []
        }
    }

    func deletePlayer(playerVM: PlayerVM) {
        let fetchRequest: NSFetchRequest<CDPlayer> = CDPlayer.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", playerVM.player.name)

        do {
            let players = try context.fetch(fetchRequest)
            if let playerToDelete = players.first {
                context.delete(playerToDelete)
                saveContext()
            } else {
                print("Player not found")
            }
        } catch {
            print("Failed to fetch player for deletion: \(error)")
        }
    }

    func updatePlayer(playerVM: PlayerVM) {
        let fetchRequest: NSFetchRequest<CDPlayer> = CDPlayer.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", playerVM.player.name)

        do {
            let players = try context.fetch(fetchRequest)
            if let playerToUpdate = players.first {
                playerToUpdate.name = playerVM.player.name
                playerToUpdate.photo = playerVM.player.photo
                saveContext()
            } else {
                print("Player not found")
            }
        } catch {
            print("Failed to fetch player for update: \(error)")
        }
    }

    func saveHistorique(historique: HistoricVM) {
        let historiqueEntity = CDHistorique(context: context)
        historiqueEntity.player1_name = historique.historic.player1_name
        historiqueEntity.player2_name = historique.historic.player2_name
        historiqueEntity.time = historique.historic.time
        historiqueEntity.result = historique.historic.result
        saveContext()
    }

    func fetchHistoriques() -> [CDHistorique] {
        let fetchRequest: NSFetchRequest<CDHistorique> = CDHistorique.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch historiques: \(error)")
            return []
        }
    }
    
    func deleteHistorique(historique: Historique) {
        let fetchRequest: NSFetchRequest<CDHistorique> = CDHistorique.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "player1_name == %@ AND player2_name == %@ AND time == %@", historique.player1_name, historique.player2_name, historique.time)

        do {
            let historiques = try context.fetch(fetchRequest)
            if let historiqueToDelete = historiques.first {
                context.delete(historiqueToDelete)
                saveContext()
            } else {
                print("Historique not found")
            }
        } catch {
            print("Failed to fetch historique for deletion: \(error)")
        }
    }

    func countVictories(for player: String) -> Int {
        let fetchRequest: NSFetchRequest<CDHistorique> = CDHistorique.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(player1_name == %@ AND result == player1_name) OR (player2_name == %@ AND result == player2_name)", player, player)

        do {
            return try context.fetch(fetchRequest).count
        } catch {
            print("Failed to fetch victories for player: \(error)")
            return 0
        }
    }

    func countDefeats(for player: String) -> Int {
        let fetchRequest: NSFetchRequest<CDHistorique> = CDHistorique.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(player1_name == %@ AND result != player1_name) OR (player2_name == %@ AND result != player2_name)", player, player)

        do {
            return try context.fetch(fetchRequest).count
        } catch {
            print("Failed to fetch defeats for player: \(error)")
            return 0
        }
    }

}
