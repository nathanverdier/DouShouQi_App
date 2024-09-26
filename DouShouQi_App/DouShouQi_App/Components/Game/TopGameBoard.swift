//
//  TitlePageFrame.swift
//  DouShouQi_App
//
//  Created by Nathan Verdier on 26/05/2024.
//

import SwiftUI
import DouShouQiModel

struct TopGameBoard: View {
    @ObservedObject var gameVM: PlayingGameVM
    @ObservedObject var chronoVM: ChronometerViewModel
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
                Text("\(gameVM.currentPlayerName)'s Turn")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color(gameVM.currentPlayerColor))
            .cornerRadius(10)
            
            Spacer().frame(height: 20)
            
            HStack {
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text(chronoVM.formattedTime())
                        .font(.title)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                HStack {
                    Text("Last move :")
                        .font(.title2)
                        .foregroundColor(.black)
                    Text(gameVM.lastPieceMoved)
                    Text(gameVM.lastMove)
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .background(Color.red.opacity(0.5))
    }
}
