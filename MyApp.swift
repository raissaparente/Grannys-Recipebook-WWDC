import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            Controller()
                .onAppear {
                    SoundManager.playerInstance.playBackground()
                }
        }
        
    }
}
