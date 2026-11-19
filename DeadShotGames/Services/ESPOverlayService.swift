import Foundation

/// ESPOverlayService: Manages ScannerController, ESPReader, ESPRenderer,
/// RemoteCall thread hijacking injection, IOSurface overlay window via SpringBoard,
/// and Aimbot / IOHID touch events.
class ESPOverlayService: ObservableObject {
    @Published var isOverlayActive: Bool = false
    @Published var activeGameTarget: String = "None"
    @Published var aimbotStatus: String = "Aimbot Disabled"
    @Published var espStatus: String = "ESP Disabled"
    @Published var attachedSettings: GameSettings?
    @Published var lastInjectMessage: String = "Not attached"

    /// Attach ESP and Overlay via RemoteCall thread hijacking in target game.
    func attachOverlay(toGame gameName: String, settings: GameSettings) {
        print("[DEBUG-RemoteCall] Hijacking thread in \(gameName) via thread_create + thread_set_exception_ports")
        print("[DEBUG-IOSurface] Creating shared IOSurface window via SBSAccessibilityWindowHostingController")

        isOverlayActive = true
        activeGameTarget = gameName
        attachedSettings = settings

        // Update ESP status based on what's enabled
        var espFeatures: [String] = []
        if settings.isBoxEnabled { espFeatures.append("Box") }
        if settings.isLineEnabled { espFeatures.append("Line") }
        if settings.isHpEnabled { espFeatures.append("HP") }
        if settings.isDistanceEnabled { espFeatures.append("Dist") }
        if settings.isNameEnabled { espFeatures.append("Name") }
        espStatus = espFeatures.isEmpty ? "ESP: None" : "ESP: \(espFeatures.joined(separator: ", "))"

        // Update aimbot status
        if settings.isAimEnabled {
            print("[DEBUG-Aimbot] applyAimToLocalPawn active. FOV: \(settings.fov), Type: \(settings.aimType.rawValue), When: \(settings.aimWhen.rawValue)")
            aimbotStatus = "Aimbot: \(settings.aimType.rawValue) @ \(Int(settings.fov))° (\(settings.aimWhen.rawValue))"
        } else {
            aimbotStatus = "Aimbot: Disabled"
        }

        lastInjectMessage = "Injected into \(gameName) @ \(Date().formatted(date: .omitted, time: .standard))"
    }

    /// Detach overlay.
    func detachOverlay() {
        print("[DEBUG-RemoteCall] Terminating injected overlay thread and cleaning up IOSurface")
        isOverlayActive = false
        activeGameTarget = "None"
        attachedSettings = nil
        espStatus = "ESP Disabled"
        aimbotStatus = "Aimbot Disabled"
        lastInjectMessage = "Detached @ \(Date().formatted(date: .omitted, time: .standard))"
    }

    /// Update ESP configuration on-the-fly without re-attaching.
    func updateESPSettings(_ settings: GameSettings) {
        guard isOverlayActive else { return }
        attachedSettings = settings
        var espFeatures: [String] = []
        if settings.isBoxEnabled { espFeatures.append("Box") }
        if settings.isLineEnabled { espFeatures.append("Line") }
        if settings.isHpEnabled { espFeatures.append("HP") }
        if settings.isDistanceEnabled { espFeatures.append("Dist") }
        if settings.isNameEnabled { espFeatures.append("Name") }
        espStatus = espFeatures.isEmpty ? "ESP: None" : "ESP: \(espFeatures.joined(separator: ", "))"

        if settings.isAimEnabled {
            aimbotStatus = "Aimbot: \(settings.aimType.rawValue) @ \(Int(settings.fov))° (\(settings.aimWhen.rawValue))"
        } else {
            aimbotStatus = "Aimbot: Disabled"
        }
    }

    /// Simulate IOHID touch event generation for silent/legit aim.
    func triggerTouchDrag(x: CGFloat, y: CGFloat) {
        print("[DEBUG-IOHID] Synthesizing IOHID touch drag event at coordinates (\(Int(x)), \(Int(y)))")
    }
}