//
//  SplashScreenView.swift
//  DouShouQi_App
//
//  Created by étudiant on 27/05/2024.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        TitlePageFrame(Text: "DOU SHOU QI", ImageWidth: 200, ImageHeight: 200)
            .onAppear {
                playSound(named: "SplashScreenSound")
            }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
