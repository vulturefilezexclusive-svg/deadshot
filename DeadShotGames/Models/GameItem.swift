import Foundation

enum GameStatus: String, Codable, CaseIterable {
    case active = "Active"
    case preparing = "Preparing"
    case updating = "Updating"
    case maintenance = "Maintenance"
}

enum AimType: String, CaseIterable, Identifiable, Codable {
    case head = "Head"
    case body = "Body"
    var id: String { rawValue }
}

enum AimWhen: String, CaseIterable, Identifiable, Codable {
    case always = "Always"
    case firing = "Firing"
    var id: String { rawValue }
}

struct GameSettings: Codable, Equatable {
    var isBoxEnabled: Bool = true
    var isLineEnabled: Bool = true
    var isHpEnabled: Bool = true
    var isDistanceEnabled: Bool = true
    var isNameEnabled: Bool = true
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
        GameItem(id: "wild-rift-ds", name: "Wild Rift DS", subtitle: "com.riotgames.league.wildrift", iconName: "gamecontroller.fill", status: .active, version: "v4.4.0", settings: GameSettings()),
        GameItem(id: "free-fire-dark-sword", name: "Free Fire DarkSword", subtitle: "Vietnamese • DarkSword", iconName: "flame.fill", status: .preparing, version: "v2.5", settings: GameSettings(isBoxEnabled: true, isLineEnabled: true, isHpEnabled: true, isDistanceEnabled: true, isNameEnabled: true, isAimEnabled: true, fov: 120, aimType: .head, aimWhen: .firing)),
        GameItem(id: "free-fire-max-ds", name: "Free Fire MAX DS", subtitle: "com.dts.freefiremax", iconName: "bolt.fill", status: .active, version: "v2.102.1", settings: GameSettings()),
        GameItem(id: "crossfire-mobile-ds", name: "CrossFire Mobile DS", subtitle: "com.tencent.tmgp.cf", iconName: "scope", status: .updating, version: "v1.9.4", settings: GameSettings()),
        GameItem(id: "8-ball-pool-ds", name: "8 Ball Pool DS", subtitle: "com.miniclip.eightballpool", iconName: "circle.grid.2x2.fill", status: .active, version: "v5.14.0", settings: GameSettings()),
        GameItem(id: "codm-vn-ds", name: "Call of Duty Mobile VN DS", subtitle: "com.vng.codm", iconName: "cross.case.fill", status: .active, version: "v1.0.38", settings: GameSettings()),
        GameItem(id: "codm-global-ds", name: "Call of Duty Mobile Global DS", subtitle: "com.activision.callofduty.shooter", iconName: "shield.fill", status: .active, version: "v1.0.38", settings: GameSettings())
    ]
}
