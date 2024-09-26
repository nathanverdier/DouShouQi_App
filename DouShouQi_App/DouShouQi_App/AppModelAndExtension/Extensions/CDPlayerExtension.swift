//
//  CDPlayerExtension.swift
//  DouShouQi_App
//
//  Created by étudiant on 14/06/2024.
//

import Foundation
import CoreData

extension CDPlayer {
    func toModel() -> Player {
        return Player(name: self.name ?? "", photo: self.photo ?? "")
    }
    
    convenience init(name: String, photo: String, context: NSManagedObjectContext){
        self.init(context: context)
        self.name = name
        self.photo = photo
    }
}

