import SwiftUI

@main
struct DeadShotGamesApp: App {
    @StateObject private var coordinator = ServicesCoordinator()
    
    init() {
        _ = DiagnosticLogger.shared
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(coordinator)
        }
    }
}