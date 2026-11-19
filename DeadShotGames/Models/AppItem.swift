import Foundation

struct AppItem: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let bundleId: String
    let iconName: String
    let category: String
    var isSelected: Bool
    
    static let sampleApps: [AppItem] = [
        AppItem(id: "app-1", name: "DeadShot Launcher Pro", bundleId: "com.dsgames.launcher.pro", iconName: "star.fill", category: "Utilities", isSelected: true),
        AppItem(id: "app-2", name: "DS Overlay Utility", bundleId: "com.dsgames.overlay", iconName: "square.3.layers.3d.down.right", category: "Gaming", isSelected: false),
        AppItem(id: "app-3", name: "Network Optimizer DS", bundleId: "com.dsgames.network.optimizer", iconName: "wifi", category: "Network", isSelected: false),
        AppItem(id: "app-4", name: "FPS Counter & Monitor", bundleId: "com.dsgames.fpsmonitor", iconName: "speedometer", category: "Monitoring", isSelected: true),
        AppItem(id: "app-5", name: "DS Macro Studio", bundleId: "com.dsgames.macro", iconName: "wand.and.stars", category: "Automation", isSelected: false),
        AppItem(id: "app-6", name: "Cloud Save Manager", bundleId: "com.dsgames.cloudsave", iconName: "icloud.and.arrow.down.fill", category: "Storage", isSelected: false),
        AppItem(id: "app-7", name: "DS Voice Enhancer", bundleId: "com.dsgames.voice", iconName: "mic.fill", category: "Audio", isSelected: false),
        AppItem(id: "app-8", name: "Theme Customizer DS", bundleId: "com.dsgames.theme", iconName: "paintpalette.fill", category: "Personalization", isSelected: false)
    ]
}
