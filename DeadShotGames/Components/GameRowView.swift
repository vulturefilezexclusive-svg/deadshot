import SwiftUI

struct GameRowView: View {
    let game: GameItem
    let onPlayTapped: () -> Void
    let onInfoTapped: () -> Void
    let onSettingsTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 14) {
            // Game Icon Placeholder
            ZStack {
                RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusSmall)
                    .fill(DeadShotGamesTheme.backgroundTertiary)
                    .frame(width: 52, height: 52)
                
                Image(systemName: game.iconName)
                    .font(.system(size: 24))
                    .foregroundColor(DeadShotGamesTheme.accentBlue)
            }
            .overlay(
                RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusSmall)
                    .stroke(DeadShotGamesTheme.separator, lineWidth: 0.5)
            )
            
            // Game Info
            VStack(alignment: .leading, spacing: 4) {
                Text(game.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(DeadShotGamesTheme.textPrimary)
                    .lineLimit(1)
                
                Text(game.subtitle)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(DeadShotGamesTheme.textSecondary)
                    .lineLimit(1)
                
                HStack(spacing: 8) {
                    GameStatusView(status: game.status)
                    
                    Text("•")
                        .foregroundColor(DeadShotGamesTheme.textTertiary)
                    
                    Text(game.version)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(DeadShotGamesTheme.textSecondary)
                }
                .padding(.top, 2)
            }
            
            Spacer()
            
            // Action Buttons
            HStack(spacing: 10) {
                // Info Button
                Button(action: onInfoTapped) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(DeadShotGamesTheme.textSecondary)
                        .frame(width: 36, height: 36)
                        .background(DeadShotGamesTheme.backgroundTertiary)
                        .clipShape(Circle())
                }
                
                // Play / Launch Button
                Button(action: onPlayTapped) {
                    Text("PLAY")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(DeadShotGamesTheme.accentBlueGradient)
                        .cornerRadius(20)
                        .shadow(color: DeadShotGamesTheme.accentBlue.opacity(0.4), radius: 6, x: 0, y: 3)
                }
            }
        }
        .padding(14)
        .dsCardStyle()
        .contentShape(Rectangle())
        .onTapGesture(perform: onSettingsTapped)
    }
}
