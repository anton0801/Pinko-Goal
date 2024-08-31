import SwiftUI

struct ContentView: View {
    
    @StateObject var userManager = UserManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pinko\nGoal")
                    .font(.custom("Kanit-Bold", size: 62))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                NavigationLink(destination: LevelsView()
                    .environmentObject(userManager)
                    .navigationBarBackButtonHidden(true)) {
                    ButtonView(text: "Play")
                }
                
                NavigationLink(destination: ShopView()
                    .environmentObject(userManager)
                    .navigationBarBackButtonHidden(true)) {
                    ButtonView(text: "Shop")
                }
                
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


