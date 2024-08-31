import SwiftUI

struct LevelsView: View {
    
    @Environment(\.presentationMode) var presMode
    @StateObject var viewModel = LevelViewModel()
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pinko\nGoal")
                    .font(.custom("Kanit-Bold", size: 62))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                ZStack {
                    Image("pause_background")
                    LazyVGrid(columns: [
                        GridItem(.fixed(70)),
                        GridItem(.fixed(70)),
                        GridItem(.fixed(70))
                    ], spacing: 8) {
                        ForEach(levels, id: \.id) { level in
                            ZStack {
                                Image("level_back")
                                if viewModel.isLevelOpened(level) {
                                    NavigationLink(destination: PinkoGoalView(level: level)
                                        .environmentObject(viewModel)
                                        .environmentObject(userManager)
                                        .navigationBarBackButtonHidden(true)) {
                                        Text("\(level.id)")
                                            .font(.custom("Recoleta", size: 24))
                                            .foregroundColor(.white)
                                    }
                                } else {
                                    Text("\(level.id)")
                                        .font(.custom("Recoleta", size: 24))
                                        .foregroundColor(.black.opacity(0.4))
                                }
                            }
                            .padding(0)
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    presMode.wrappedValue.dismiss()
                } label: {
                    ButtonView(text: "BACK")
                }
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
    LevelsView()
        .environmentObject(UserManager())
}
