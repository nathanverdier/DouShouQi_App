//
//  EditPlayerView.swift
//  DouShouQi_App
//
//  Created by étudiant on 17/06/2024.
//

import Foundation
import SwiftUI

struct EditPlayerView: View {
    @Binding var isPresented: Bool
    @ObservedObject var player: PlayerVM
    @ObservedObject var playersVM: PlayersVM

    
    @State private var profileImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
     var playerName: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Edit Player")
                .font(.headline)
            
            TextField("Player Name", text: $player.player.name)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } else {
                Button(action: {
                    showImagePicker = true
                }) {
                    Text("Select Profile Photo")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
            HStack {
                Button(action: {
                    if let image = profileImage, let imageData = image.jpegData(compressionQuality: 0.8) {
                        let filename = UUID().uuidString + ".jpg"
                        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                        let documentsDirectory = paths[0]
                        let fileURL = documentsDirectory.appendingPathComponent(filename)
                        try? imageData.write(to: fileURL)
                        player.player.photo = fileURL.path
                    }
                    playersVM.updatePlayer(playerVM: player, playerName: playerName)
                    isPresented = false
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $profileImage, sourceType: imagePickerSourceType)
        }
    }
}
