//
//  HistoricVM.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 29/05/2024.
//

import Foundation
import SwiftUI
import DouShouQiModel

class HistoricVM: ObservableObject, Identifiable, Hashable{
    
    public static func == (lhs: HistoricVM, rhs: HistoricVM) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @Published var historic: Historique
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    
    init(historic: Historique) {
        self.historic = historic
    }
}
