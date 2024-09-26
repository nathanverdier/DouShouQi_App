import SwiftUI

struct ButtonView: View {
    var button1Title: String

    var body: some View {
        VStack {
            Button(action: {
                print("\(button1Title) pressé!")
            }) {
                Text(button1Title)
                    .frame(width: 200)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct ButtonsViewPreviews: PreviewProvider {
    static var previews: some View {
        ButtonView(button1Title: "Button")
    }
}
