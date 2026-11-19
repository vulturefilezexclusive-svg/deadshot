import SwiftUI

/// DeadShotGames Design System & Theme
/// Defines color palettes, typography, and styling constants for the dark-themed UI.
struct DeadShotGamesTheme {
    // Backgrounds
    static let backgroundPrimary = Color(hex: 0x121216)
    static let backgroundSecondary = Color(hex: 0x1C1C22)
    static let backgroundTertiary = Color(hex: 0x282832)
    static let cardBackground = Color(hex: 0x1E1E26)
    static let cardBackgroundHover = Color(hex: 0x252530)
    
    // Interactive & Accents
    static let accentBlue = Color(hex: 0x0A84FF)
    static let accentBlueGradient = LinearGradient(
        colors: [Color(hex: 0x0A84FF), Color(hex: 0x0056B3)],
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
    static let separator = Color(hex: 0x38383A).opacity(0.6)
    
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
    
    func body(content: Content) -> View {
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
