//
//  SettingsView.swift
//  DouShouQi_App
//
//  Created by etudiant on 27/05/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settingsVM: SettingsVM
    
    var body: some View {
        VStack {
            TitlePageFrame(Text: "Settings")
            
            VStack {
                Divider()
                
                HStack {
                    Text("Theme")
                        .font(.headline)
                    
                    Spacer()
                    
                    CustomSwitchButton(IsOn: $settingsVM.darkTheme, imgSystemNameIsOff: SystemIcons.LightTheme, imgSystemNameIsOn: SystemIcons.DarkTheme)
                }
                
                Divider()
                
                HStack {
                    Text("Language")
                        .font(.headline)
                    
                    Spacer()
                    
                    Picker("Language", selection: $settingsVM.language) {
                        ForEach(Language.list) { language in
                            Text(language.litteral).tag(language)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Divider()
                
                HStack {
                    Text("Sound")
                        .font(.headline)
                    
                    Spacer()
                    
                    CustomSwitchButton(IsOn: $settingsVM.soundOn, imgSystemNameIsOff: SystemIcons.SoundOff, imgSystemNameIsOn: SystemIcons.SoundOn)
                }
                
                Divider()
            }
            .padding(20)
            
            Spacer()
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
