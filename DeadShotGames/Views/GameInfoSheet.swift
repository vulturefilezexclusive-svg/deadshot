import SwiftUI

struct GameInfoSheet: View {
    let game: GameItem
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                DeadShotGamesTheme.backgroundPrimary
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header Card
                        HStack(spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusMedium)
                                    .fill(DeadShotGamesTheme.backgroundTertiary)
                                    .frame(width: 64, height: 64)
                                
                                Image(systemName: game.iconName)
                                    .font(.system(size: 32))
                                    .foregroundColor(DeadShotGamesTheme.accentRed)
                            }
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(game.name)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(DeadShotGamesTheme.textPrimary)
                                
                                Text(game.subtitle)
                                    .font(.system(size: 13))
                                    .foregroundColor(DeadShotGamesTheme.textSecondary)
                                
                                GameStatusView(status: game.status)
                            }
                            
                            Spacer()
                        }
                        .padding(16)
                        .dsCardStyle()
                        
                        // Details Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Package Information")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(DeadShotGamesTheme.textPrimary)
                            
                            VStack(spacing: 0) {
                                infoRow(title: "Version", value: game.version)
                                Divider().background(DeadShotGamesTheme.separator)
                                infoRow(title: "Bundle ID", value: game.subtitle)
                                Divider().background(DeadShotGamesTheme.separator)
                                infoRow(title: "Architecture", value: "arm64 (iOS 16.1+)")
                                Divider().background(DeadShotGamesTheme.separator)
                                infoRow(title: "Injection Engine", value: "DS Core v2.5")
                            }
                            .padding(16)
                            .dsCardStyle()
                        }
                        
                        // Features Summary
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Included Modules")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(DeadShotGamesTheme.textPrimary)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                featureRow(icon: "eye.fill", title: "ESP Overlay", desc: "Box, Line, HP, Distance, and Name renderers")
                                featureRow(icon: "scope", title: "Advanced Aim Assist", desc: "Custom FOV, Head/Body targeting, Firing triggers")
                                featureRow(icon: "shield.checkered", title: "Bypass Protection", desc: "Anti-cheat integration & memory shield")
                            }
                            .padding(16)
                            .dsCardStyle()
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Game Information")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(DeadShotGamesTheme.textSecondary)
                            .font(.system(size: 20))
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(DeadShotGamesTheme.textSecondary)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(DeadShotGamesTheme.textPrimary)
        }
        .padding(.vertical, 8)
    }
    
    private func featureRow(icon: String, title: String, desc: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(DeadShotGamesTheme.accentRed)
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(DeadShotGamesTheme.textPrimary)
                Text(desc)
                    .font(.system(size: 12))
                    .foregroundColor(DeadShotGamesTheme.textSecondary)
            }
        }
        .padding(.vertical, 4)
    }
}
