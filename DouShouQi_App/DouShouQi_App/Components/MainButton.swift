//
//  MainButton.swift
//  DouShouQi_App
//
//  Created by etudiant on 16/05/2024.
//

import SwiftUI

struct MainButton: View {
    var body: some View {
        Button(action: {
            // Code à exécuter lorsque l'utilisateur appuie sur le bouton
            print("Bouton appuyé !")
        }) {
            // Label pour le bouton (par exemple, du texte ou une icône)
            Text("Appuyez ici")
                .padding() // Ajoute un peu d'espace autour du texte
                .background(Color.blue) // Couleur de fond du bouton
                .foregroundColor(.white) // Couleur du texte
                .cornerRadius(10) // Coins arrondis
        }
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton()
    }
}
