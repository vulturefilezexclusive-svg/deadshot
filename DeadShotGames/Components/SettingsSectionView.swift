import SwiftUI

struct SettingsSectionView<Content: View>: View {
    let title: String
    let subtitle: String?
    @ViewBuilder let content: Content
    
    init(title: String, subtitle: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(DeadShotGamesTheme.textPrimary)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(DeadShotGamesTheme.textSecondary)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 4)
            
            VStack(spacing: 12) {
                content
            }
            .padding(16)
            .dsCardStyle()
        }
    }
}
