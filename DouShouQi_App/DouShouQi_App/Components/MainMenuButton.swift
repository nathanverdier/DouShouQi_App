//
//  MainMenuButton.swift
//  Dou}Qi_App
//
//  Created by Rémi REGNAULT on 16/05/2024.
//

import SwiftUI

struct MainMenuButton: View {
    // Text Params
    var text: String
    var sound: String
    
    // Fonction à executer
    var onClick: (() -> Void)?
    
    // Button Alignment
    var horizontalAlignment: Alignment = .center
    
    // Button corner radius
    var topLeftCorner: CGFloat = 0
    var topRightCorner: CGFloat = 0
    var bottomLeftCorner: CGFloat = 0
    var bottomRightCorner: CGFloat = 0
    
    var body: some View {
        Button(action: {
            // playSound(named: sound)
            onClick?()
        }) {
            Text(text.uppercased())
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(
                    Color.red
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 0, height: 0)))
                        .mask(RoundedCornersShape(cornerRadii: (topLeft: topLeftCorner, topRight: topRightCorner, bottomLeft: bottomLeftCorner, bottomRight: bottomRightCorner)))
                )
                .frame(width: UIScreen.main.bounds.width / 1.7)
                .frame(maxWidth: .infinity, alignment: horizontalAlignment)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct RoundedCornersShape: Shape {
    var cornerRadii: (topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat)
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        // Top left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadii.topLeft))
        path.addArc(withCenter: CGPoint(x: rect.minX + cornerRadii.topLeft, y: rect.minY + cornerRadii.topLeft),
                    radius: cornerRadii.topLeft,
                    startAngle: .pi,
                    endAngle: -.pi / 2,
                    clockwise: true)
        
        // Top right corner
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadii.topRight, y: rect.minY))
        path.addArc(withCenter: CGPoint(x: rect.maxX - cornerRadii.topRight, y: rect.minY + cornerRadii.topRight),
                    radius: cornerRadii.topRight,
                    startAngle: -.pi / 2,
                    endAngle: 0,
                    clockwise: true)
        
        // Bottom right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadii.bottomRight))
        path.addArc(withCenter: CGPoint(x: rect.maxX - cornerRadii.bottomRight, y: rect.maxY - cornerRadii.bottomRight),
                    radius: cornerRadii.bottomRight,
                    startAngle: 0,
                    endAngle: .pi / 2,
                    clockwise: true)
        
        // Bottom left corner
        path.addLine(to: CGPoint(x: rect.minX + cornerRadii.bottomLeft, y: rect.maxY))
        path.addArc(withCenter: CGPoint(x: rect.minX + cornerRadii.bottomLeft, y: rect.maxY - cornerRadii.bottomLeft),
                    radius: cornerRadii.bottomLeft,
                    startAngle: .pi / 2,
                    endAngle: .pi,
                    clockwise: true)
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadii.topLeft))
        
        return Path(path.cgPath)
    }
}

struct MainMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuButton(text: "test", sound: "TitleScreenButtonSound", horizontalAlignment: .leading, topRightCorner: 10, bottomRightCorner: 10)
    }
}
