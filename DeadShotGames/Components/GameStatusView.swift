import SwiftUI

struct GameStatusView: View {
    let status: GameStatus

    private var statusColor: Color {
        switch status {
        case .active: return DeadShotGamesTheme.statusActive
        case .preparing, .updating: return DeadShotGamesTheme.statusWarning
        case .maintenance: return DeadShotGamesTheme.statusInactive
        }
    }

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)
                .shadow(color: statusColor.opacity(0.6), radius: 4)
            Text(status.rawValue)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(DeadShotGamesTheme.textSecondary)
        }
    }
}
