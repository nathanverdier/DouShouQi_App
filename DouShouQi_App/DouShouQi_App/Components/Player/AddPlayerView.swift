//
//  AddPlayerView.swift
//  DouShouQi_App
//
//  Created by étudiant on 28/05/2024.
//

import SwiftUI
import UIKit

struct AddPlayerView: View {
    @Binding var isPresented: Bool
    @ObservedObject var playersVM: PlayersVM
    @State private var playerName: String = ""
    @State private var showAlert = false
    @State private var showImagePicker = false
    @State private var profileImage: UIImage? = nil
    @State private var profileImagePath: String = ""
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showActionSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add New Player")
                .font(.headline)
            
            TextField("Player Name", text: $playerName)
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
                    showActionSheet = true
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
                    if playersVM.contains(where: { $0.player.name.lowercased() == playerName.lowercased() }) {
                        showAlert = true
                    } else {
                        if let image = profileImage, let imageData = image.jpegData(compressionQuality: 0.8) {
                            let filename = UUID().uuidString + ".jpg"
                            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                            let documentsDirectory = paths[0]
                            let fileURL = documentsDirectory.appendingPathComponent(filename)
                            try? imageData.write(to: fileURL)
                            profileImagePath = fileURL.path
                        }
                        let newPlayer = PlayerVM(player: Player(name: playerName, photo: profileImagePath))
                        playersVM.SavePlayer(player: newPlayer)
                        isPresented = false
                    }
                }) {
                    Text("Add")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Cancel")
                        .foregroundColor(Colors.TextButton)
                        .padding()
                        .background(Colors.Button)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Colors.PopupBackground)
        .cornerRadius(20)
        .shadow(radius: 10)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Player already exists."), dismissButton: .default(Text("OK")))
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("Select Photo"), message: Text("Choose a photo from the library or take a new one."), buttons: [
                .default(Text("Photo Library")) {
                    imagePickerSourceType = .photoLibrary
                    showImagePicker = true
                },
                .default(Text("Camera")) {
                    imagePickerSourceType = .camera
                    showImagePicker = true
                },
                .cancel()
            ])
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $profileImage, sourceType: imagePickerSourceType)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
