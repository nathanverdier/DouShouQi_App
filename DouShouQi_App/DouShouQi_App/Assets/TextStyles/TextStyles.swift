//
//  TextStyles.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 16/05/2024.
//

import Foundation
import SwiftUI

protocol TextStyles: ViewModifier {}

extension Text {
    func textStyle<T: TextStyles>(_ style: T) -> some View {
        modifier(style)
    }
}

struct CustomTextStyles {
    static let Title = ViewTitleTextStyle()
}
