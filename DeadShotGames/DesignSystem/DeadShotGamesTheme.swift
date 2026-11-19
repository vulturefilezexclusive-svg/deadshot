import SwiftUI

/// DeadShotGames Design System & Theme - Formula One Red & OLED Black Edition
struct DeadShotGamesTheme {
    // OLED Black Backgrounds
    static let backgroundPrimary = Color(hex: 0x000000)
    static let backgroundSecondary = Color(hex: 0x0A0A0A)
    static let backgroundTertiary = Color(hex: 0x141414)
    static let cardBackground = Color(hex: 0x121212)
    static let cardBackgroundHover = Color(hex: 0x1C1C1C)
    
    // Formula One Red Accents
    static let accentRed = Color(hex: 0xFF1801)
    static let accentRedGradient = LinearGradient(
        colors: [Color(hex: 0xFF1801), Color(hex: 0x990000)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Status Colors
    static let statusActive = Color(hex: 0x30D158)
    static let statusWarning = Color(hex: 0xFFD60A)
    static let statusInactive = Color(hex: 0xFF453A)
    
    // Text Colors
    static let textPrimary = Color.white
    static let textSecondary = Color(hex: 0x8E8E93)
    static let textTertiary = Color(hex: 0x636366)
    
    // Borders & Dividers
    static let separator = Color(hex: 0x2C2C2E)
    
    // Corner Radii
    static let cornerRadiusSmall: CGFloat = 8
    static let cornerRadiusMedium: CGFloat = 12
    static let cornerRadiusLarge: CGFloat = 16
    static let cornerRadiusCard: CGFloat = 18
}

extension Color {
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: opacity
        )
    }
}

// Reusable Card Modifier
struct DSGameCardModifier: ViewModifier {
    var backgroundColor: Color = DeadShotGamesTheme.cardBackground
    var cornerRadius: CGFloat = DeadShotGamesTheme.cornerRadiusCard
    
    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(DeadShotGamesTheme.separator, lineWidth: 0.5)
            )
    }
}

extension View {
    func dsCardStyle(backgroundColor: Color = DeadShotGamesTheme.cardBackground, cornerRadius: CGFloat = DeadShotGamesTheme.cornerRadiusCard) -> some View {
        modifier(DSGameCardModifier(backgroundColor: backgroundColor, cornerRadius: cornerRadius))
    }
}
