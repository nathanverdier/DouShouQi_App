//
//  ContentView.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 16/05/2024.
//

import SwiftUI
import DouShouQiModel

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
