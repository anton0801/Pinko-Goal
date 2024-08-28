import SwiftUI

struct ButtonView: View {
    
    var text: String
    
    var body: some View {
        ZStack {
            Image("btn_background")
            Text(text)
                .font(.custom("Recoleta", size: 42))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ButtonView(text: "Test")
}
