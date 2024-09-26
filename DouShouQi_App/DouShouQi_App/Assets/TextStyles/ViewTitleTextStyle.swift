//
//  ViewTitleTextStyle.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 16/05/2024.
//

import Foundation
import SwiftUI

struct ViewTitleTextStyle: TextStyles {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Colors.TitleText)
            .fontWeight(.bold)
            .font(.custom(Fonts.title, size: 30))
    }
}
