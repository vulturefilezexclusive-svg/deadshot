import SwiftUI

@main
struct DeadShotGamesApp: App {
    init() {
        _ = DiagnosticLogger.shared
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
