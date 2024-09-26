//
//  HistoricListVM.swift
//  DouShouQi_App
//
//  Created by étudiant on 24/06/2024.
//

import Foundation
import SwiftUI
import DouShouQiModel

class HistoricListVM: ObservableObject {
    
    @Published var historicList: [HistoricVM]
    
    public func SavePlayer(historic: HistoricVM){
        historicList.append(historic)
        CoreDataManager.shared.saveHistorique(historique: historic)
    }
    
    public func getAllHistoric() -> [HistoricVM]{
        let coreDataPlayers = CoreDataManager.shared.fetchHistoriques()
        self.historicList = coreDataPlayers.map { HistoricVM(historic: $0.toModel()) }
        return historicList
    }
    
    public func groupByDate() -> [String: [HistoricVM]] {
        let groupedDictionary = Dictionary(grouping: historicList) { historicVM in
            return historicVM.date
        }
        return groupedDictionary
    }
    
    init() {
        historicList = []
        
        historicList = getAllHistoric()
    }
}
