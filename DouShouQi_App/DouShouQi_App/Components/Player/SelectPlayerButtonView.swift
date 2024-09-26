//
//  SelectPlayerButtonView.swift
//  DouShouQi_App
//
//  Created by etudiant on 23/05/2024.
//

import SwiftUI

struct CustomShapeLeftButton: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY)) // coin supérieur gauche
        path.addLine(to: CGPoint(x: rect.maxX - 60, y: rect.minY)) // un peu avant le coin supérieur droit
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 60)) // un peu en dessous du coin supérieur droit
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // coin inférieur droit
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // coin inférieur gauche
        path.closeSubpath()
        return path
    }
}

struct CustomShapeRightButton: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + 60, y: rect.minY)) // un peu à droite du coin supérieur gauche
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // coin supérieur droit
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // coin inférieur droit
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // coin inférieur gauche
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 60)) // un peu en dessous du coin supérieur gauche
        path.closeSubpath()
        return path
    }
}


struct SelectPlayerButtonView: View {
    
    @ObservedObject var player1:PlayerVM
    @ObservedObject var player2:PlayerVM
    
    @ObservedObject var playersVM: PlayersVM
    
    @State private var showingPopup1 = false
    @State private var showingPopup2 = false
    
    var body: some View {
        ZStack{
            Image("vs-custom")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 100, height: 100)
               .offset(y: -60)
            HStack{
                VStack (alignment: .leading) {
                    Text(player1.player.name)
                        .font(.title)
                        .padding(3)
                    Button(action: {
                        print("Button j1 pressé!")
                        showingPopup1 = true
                    }) {
                        VStack {
                            Text("+")
                                .font(.largeTitle)
                                .bold()
                            Text("Add a player")
                                .font(.body)
                                .bold()
                                .sheet(isPresented: $showingPopup1) {
                                    ShowAllPlayer(currentShowingSheet: $showingPopup1, currentPlayer: player1, otherPlayer: player2, playersVM: playersVM)
                                }
                        }
                        .frame(width: 150, height: 150)
                        .padding()
                        .border(Colors.TitleText, width: 4)
                        .foregroundColor(Colors.TitleText)
                        .cornerRadius(10)
                        .clipShape(CustomShapeLeftButton())
                    }
                }
                VStack (alignment: .trailing) {
                    Text(player2.player.name)
                        .font(.title)
                        .padding(3)
                    
                    Button(action: {
                        print("Button j2 pressé!")
                        showingPopup2 = true
                    }) {
                        VStack {
                            Text("+")
                                .font(.largeTitle)
                                .bold()
                            Text("Add a player")
                                .font(.body)
                                .bold()
                                .sheet(isPresented: $showingPopup2) {
                                    ShowAllPlayer(currentShowingSheet: $showingPopup2, currentPlayer: player2, otherPlayer: player1, playersVM: playersVM)
                                }
                        }.frame(width: 150, height: 150)
                        .padding()
                        .border(Colors.TitleText, width: 4)
                        .foregroundColor(Colors.TitleText)
                        .cornerRadius(10)
                        .clipShape(CustomShapeRightButton())
                    }
                }
            }
        }
    }
}

/*struct SelectPlayerButtonView_Previews: PreviewProvider {
    
    var player1 = PlayerVM(player: Player(name: "Linked", photo: ""))
    var player22 = PlayerVM(player: Player(name: "Horizon", photo: ""))
    
    static var previews: some View {
        @StateObject var playersVM = PlayersVM()
        SelectPlayerButtonView(player1: player1, player2: player2, playersVM: PlayersVM())
    }
}*/
