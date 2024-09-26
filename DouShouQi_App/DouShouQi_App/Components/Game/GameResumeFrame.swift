//
//  GameResumeFrame.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 21/05/2024.
//

import SwiftUI
#if DEBUG
import DouShouQiModel
#endif

struct GameResumeFrame: View {
    
    // Players Params
    let historicVm: HistoricVM
    
    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("\(historicVm.historic.player1_name) vs \(historicVm.historic.player2_name)")
                        .font(.headline)
                    
                    Text(historicVm.historic.result)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(historicVm.historic.time)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(.gray, lineWidth: 2)
            )
        }.padding(2)
    }
}
