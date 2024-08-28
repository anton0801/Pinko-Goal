import SwiftUI

struct SettingsGameView: View {
    
    @Environment(\.presentationMode) var presMode
    
    @State var soundVolume = UserDefaults.standard.bool(forKey: "sound")
    @State var musicVolume = UserDefaults.standard.bool(forKey: "music")
    
    var body: some View {
        VStack {
            Text("Pinko\nGoal")
                .font(.custom("Kanit-Bold", size: 62))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            
            Spacer()
            
            ZStack {
                Image("pause_background")
                VStack {
                    Text("Settings")
                         .font(.custom("Kanit-Bold", size: 42))
                         .multilineTextAlignment(.center)
                         .foregroundColor(.white)
                    
                    HStack {
                        Text("Music")
                             .font(.custom("Kanit-Medium", size: 28))
                             .foregroundColor(.white)
                        Button {
                            withAnimation(.linear(duration: 0.5)) {
                                musicVolume = !musicVolume
                            }
                        } label: {
                            if musicVolume {
                                Image("volume_on")
                            } else {
                                Image("volume_off")
                            }
                        }
                    }
                    
                    HStack {
                        Text("Sound")
                             .font(.custom("Kanit-Medium", size: 28))
                             .foregroundColor(.white)
                        Button {
                            withAnimation(.linear(duration: 0.5)) {
                                soundVolume = !soundVolume
                            }
                        } label: {
                            if soundVolume {
                                Image("volume_on")
                            } else {
                                Image("volume_off")
                            }
                        }
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
        .onChange(of: soundVolume) { newValue in
            UserDefaults.standard.set(soundVolume, forKey: "sound")
        }
        .onChange(of: musicVolume) { newValue in
            UserDefaults.standard.set(musicVolume, forKey: "music")
        }
        .background(
            Image("menu_background")
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    SettingsGameView()
}
