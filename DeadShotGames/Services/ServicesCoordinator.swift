import Foundation

/// ServicesCoordinator: Central container for all DSGames backend services.
/// Injected at app root via @EnvironmentObject so any view can access the live instances.
final class ServicesCoordinator: ObservableObject {
    let memoryEngine = MemoryEngine()
    let stealthService = StealthService()
    let espOverlayService = ESPOverlayService()
    let processManager = ProcessManager()
    
    /// Convenience: run the full injection flow against a specific game.
    /// - Parameters:
    ///   - game: The target game to inject into.
    ///   - settings: ESP/aim settings to apply at injection time.
    func inject(into game: GameItem, settings: GameSettings) {
        stealthService.initializeStealth()
        memoryEngine.initializeKRW()
        espOverlayService.attachOverlay(toGame: game.name, settings: settings)
        
        if espOverlayService.isOverlayActive && memoryEngine.isConnectedToKernel {
            let health = memoryEngine.readPlayerHealth()
            let target = memoryEngine.readAimTarget()
            print("[DEBUG-integration] Read back: health=\(health) aimTarget=\(target)")
        }
    }
    
    /// Detach from any currently injected game.
    func detach() {
        espOverlayService.detachOverlay()
        memoryEngine.disconnectKRW()
    }
    
    /// Re-inject runtime hooks for a utility/app.
    func reInjectUtility(named name: String) {
        stealthService.initializeStealth()
        memoryEngine.initializeKRW()
        if espOverlayService.isOverlayActive {
            espOverlayService.updateESPSettings(GameSettings())
        }
    }
}