import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Pinko\nGoal")
                    .font(.custom("Kanit-Bold", size: 62))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                NavigationLink(destination: LevelsView()
                    .navigationBarBackButtonHidden(true)) {
                    ButtonView(text: "Play")
                }
                
//                NavigationLink(destination: EmptyView()) {
//                    ButtonView(text: "Shop")
//                }
                
                NavigationLink(destination: SettingsGameView()
                    .navigationBarBackButtonHidden(true)) {
                    ButtonView(text: "Settings")
                }
                
                Spacer()
            }
            .background(
                Image("menu_background")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}


