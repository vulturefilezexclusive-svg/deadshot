import Foundation

enum GameStatus: String, Codable, CaseIterable {
    case active = "Active"
    case updating = "Updating"
    case maintenance = "Maintenance"
    
    var colorName: String {
        switch self {
        case .active: return "green"
        case .updating: return "yellow"
        case .maintenance: return "red"
        }
    }
}

enum AimType: String, CaseIterable, Identifiable {
    case head = "Head"
    case body = "Body"
    
    var id: String { rawValue }
}

enum AimWhen: String, CaseIterable, Identifiable {
    case always = "Always"
    case firing = "Firing"
    
    var id: String { rawValue }
}

struct GameSettings: Codable, Equatable {
    // ESP Settings
    var isBoxEnabled: Bool = true
    var isLineEnabled: Bool = true
    var isHpEnabled: Bool = true
    var isDistanceEnabled: Bool = true
    var isNameEnabled: Bool = true
    
    // Aim Settings
    var isAimEnabled: Bool = false
    var fov: Double = 90.0
    var aimType: AimType = .head
    var aimWhen: AimWhen = .always
}

struct GameItem: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let subtitle: String
    let iconName: String
    var status: GameStatus
    let version: String
    var settings: GameSettings
    
    static let sampleGames: [GameItem] = [
        GameItem(
            id: "wild-rift-ds",
            name: "Wild Rift DS",
            subtitle: "com.riotgames.league.wildrift",
            iconName: "gamecontroller.fill",
            status: .active,
            version: "v4.4.0",
            settings: GameSettings(isBoxEnabled: true, isLineEnabled: true, isHpEnabled: true, isDistanceEnabled: true, isNameEnabled: true, isAimEnabled: false, fov: 90.0, aimType: .head, aimWhen: .always)
        ),
        GameItem(
            id: "free-fire-th-ds",
            name: "Free Fire TH DS",
            subtitle: "com.dts.freefireth",
            iconName: "flame.fill",
            status: .active,
            version: "v1.102.1",
            settings: GameSettings(isBoxEnabled: true, isLineEnabled: true, isHpEnabled: true, isDistanceEnabled: false, isNameEnabled: true, isAimEnabled: true, fov: 120.0, aimType: .head, aimWhen: .firing)
        ),
        GameItem(
            id: "free-fire-max-ds",
            name: "Free Fire MAX DS",
            subtitle: "com.dts.freefiremax",
            iconName: "bolt.fill",
            status: .active,
            version: "v2.102.1",
            settings: GameSettings(isBoxEnabled: true, isLineEnabled: false, isHpEnabled: true, isDistanceEnabled: true, isNameEnabled: true, isAimEnabled: false, fov: 100.0, aimType: .body, aimWhen: .always)
        ),
        GameItem(
            id: "crossfire-mobile-ds",
            name: "CrossFire Mobile DS",
            subtitle: "com.tencent.tmgp.cf",
            iconName: "scope",
            status: .updating,
            version: "v1.9.4",
            settings: GameSettings(isBoxEnabled: false, isLineEnabled: false, isHpEnabled: false, isDistanceEnabled: false, isNameEnabled: false, isAimEnabled: false, fov: 90.0, aimType: .head, aimWhen: .always)
        ),
        GameItem(
            id: "8-ball-pool-ds",
            name: "8 Ball Pool DS",
            subtitle: "com.miniclip.eightballpool",
            iconName: "circle.grid.2x2.fill",
            status: .active,
            version: "v5.14.0",
            settings: GameSettings(isBoxEnabled: true, isLineEnabled: true, isHpEnabled: false, isDistanceEnabled: true, isNameEnabled: false, isAimEnabled: true, fov: 60.0, aimType: .head, aimWhen: .always)
        ),
        GameItem(
            id: "codm-vn-ds",
            name: "Call of Duty Mobile VN DS",
            subtitle: "com.vng.codm",
            iconName: "cross.case.fill",
            status: .active,
            version: "v1.0.38",
            settings: GameSettings(isBoxEnabled: true, isLineEnabled: true, isHpEnabled: true, isDistanceEnabled: true, isNameEnabled: true, isAimEnabled: false, fov: 90.0, aimType: .head, aimWhen: .firing)
        ),
        GameItem(
            id: "codm-global-ds",
            name: "Call of Duty Mobile Global DS",
            subtitle: "com.activision.callofduty.shooter",
            iconName: "shield.fill",
            status: .active,
            version: "v1.0.38",
            settings: GameSettings(isBoxEnabled: true, isLineEnabled: true, isHpEnabled: true, isDistanceEnabled: true, isNameEnabled: true, isAimEnabled: true, fov: 90.0, aimType: .head, aimWhen: .always)
        )
    ]
}
