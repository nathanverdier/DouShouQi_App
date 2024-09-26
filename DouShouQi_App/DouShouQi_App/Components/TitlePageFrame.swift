//
//  TitlePageFrame.swift
//  DouShouQi_App
//
//  Created by Rémi REGNAULT on 16/05/2024.
//

import SwiftUI

struct TitlePageFrame: View {
    
    // Text Params
    var Text: String
    
    // Image Params
    var ImageWidth: CGFloat = 200
    var ImageHeight: CGFloat = 200
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Image(AppImages.TitleImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ImageWidth, height: ImageHeight)
                    
                SwiftUI.Text(self.Text)
                    .textStyle(CustomTextStyles.Title)
                
            }
        }
    }
}

struct TitlePageFrame_Previews: PreviewProvider {
    static var previews: some View {
        TitlePageFrame(Text: "DouShouQi")
    }
}
