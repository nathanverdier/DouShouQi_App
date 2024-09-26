//
//  Historique.swift
//  DouShouQi_App
//
//  Created by étudiant on 22/06/2024.
//

import Foundation

public class Historique{
    var player1_name: String
    var player2_name: String
    var time: String
    var result: String
    
    init(player1_name: String, player2_name: String, time: String, result: String){
        self.player1_name = player1_name
        self.player2_name = player2_name
        self.result = result
        self.time = time
    }
}
