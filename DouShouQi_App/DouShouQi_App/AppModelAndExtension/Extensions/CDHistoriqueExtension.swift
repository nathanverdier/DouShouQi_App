//
//  CDHistoriqueExtension.swift
//  DouShouQi_App
//
//  Created by étudiant on 22/06/2024.
//

import Foundation
import CoreData

extension CDHistorique {
    func toModel() -> Historique {
        return Historique(
            player1_name: self.player1_name ?? "",
            player2_name: self.player2_name ?? "",
            time: self.time ?? "",
            result: self.result ?? ""
        )
    }
    
    convenience init(player1_name: String, player2_name: String, time: String, result: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.player1_name = player1_name
        self.player2_name = player2_name
        self.time = time
        self.result = result
    }
}
