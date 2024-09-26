//
//  CustomSwitchButton.swift
//  DouShouQi_App
//
//  Created by etudiant on 27/05/2024.
//

import SwiftUI

struct CustomSwitchButton: View {
    
    // Boolean
    @Binding var IsOn: Bool
    
    // Image when Off
    var imgSystemNameIsOff: String
    var imgIsOffWidth: CGFloat = 25
    var imgIsOffHeight: CGFloat = 25
    
    // Image when Off
    var imgSystemNameIsOn: String
    var imgIsOnWidth: CGFloat = 25
    var imgIsOnHeight: CGFloat = 25
    
    var body: some View {
        HStack {
            VStack {
                if (!IsOn) {
                    Image(systemName: imgSystemNameIsOff)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgIsOffWidth, height: imgIsOffHeight)
                }
            }.frame(width: imgIsOffWidth, height: imgIsOffHeight)
            
            Toggle("isOn", isOn: $IsOn)
                .labelsHidden()
            
            VStack {
                if (IsOn) {
                    Image(systemName: imgSystemNameIsOn)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgIsOnWidth, height: imgIsOnHeight)
                }
            }.frame(width: imgIsOffWidth, height: imgIsOffHeight)
        }
    }
}

//struct CustomSwitchButton_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var isOn: Bool = false
//        CustomSwitchButton(IsOn: $isOn, imgNameIsOff: AppImages.TitleImage, imgNameIsOn: AppImages.TitleImage)
//    }
//}
