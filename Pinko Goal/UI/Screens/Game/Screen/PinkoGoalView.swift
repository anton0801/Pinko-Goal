import SwiftUI
import SpriteKit

struct PinkoGoalView: View {
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var levelsViewModel: LevelViewModel
    var level: Level
    @State var pinkoScene: PinkoGoalScene!
    
    
    var body: some View {
        ZStack {
            if let pinkoScene = pinkoScene {
                SpriteView(scene: pinkoScene)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            pinkoScene = PinkoGoalScene(level: level)
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("game_over"))) { _ in
            pinkoScene = pinkoScene.restartGame()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("exit"))) { _ in
            presMode.wrappedValue.dismiss()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("game_win"))) { _ in
            levelsViewModel.openLevel(level.id + 1)
            presMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    PinkoGoalView(level: Level(id: 1, touchCount: 1))
        .environmentObject(LevelViewModel())
}
