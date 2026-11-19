import SwiftUI

struct AppSearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search by app name or bundle ID..."
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(DeadShotGamesTheme.textSecondary)
                .font(.system(size: 16, weight: .medium))
            
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(DeadShotGamesTheme.textSecondary))
                .font(.system(size: 15))
                .foregroundColor(DeadShotGamesTheme.textPrimary)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(DeadShotGamesTheme.textSecondary)
                        .font(.system(size: 16))
                }
            }
        }
        .padding(12)
        .background(DeadShotGamesTheme.backgroundTertiary)
        .cornerRadius(DeadShotGamesTheme.cornerRadiusMedium)
        .overlay(
            RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusMedium)
                .stroke(DeadShotGamesTheme.separator, lineWidth: 0.5)
        )
    }
}
