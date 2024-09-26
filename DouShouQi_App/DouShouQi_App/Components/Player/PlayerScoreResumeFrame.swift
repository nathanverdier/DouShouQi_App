//
//  PlayerScoreResumeFrame.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 21/05/2024.
//

import SwiftUI

struct PlayerScoreResumeFrame: View {
    
    // Player Params
    let Name: String
    let Rank: Int
    let Wins: Int
    let Looses: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("\(Rank)")
                    .font(.headline)
                    .frame(width: 50, alignment: .trailing)
                
                Text(Name)
                
                Spacer()
                
                Text("\(Wins)")
                    .frame(width: 55, alignment: .trailing)
                
                Text("\(Looses)")
                    .frame(width: 55, alignment: .trailing)

            }
            .padding(10)
        }
    }
}

struct PlayerScoreResumeFrame_Previews: PreviewProvider {
    static var previews: some View {
        PlayerScoreResumeFrame(Name: "Michel Polnaref", Rank: 178, Wins: 0, Looses: 296)
    }
}
