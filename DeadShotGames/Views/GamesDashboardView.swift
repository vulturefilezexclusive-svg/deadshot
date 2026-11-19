import SwiftUI

struct GamesDashboardView: View {
    @State private var games: [GameItem] = GameItem.sampleGames
    @State private var selectedGame: GameItem?
    @State private var infoGame: GameItem?
    @State private var selectedLanguage: String = "English"
    @State private var showLanguageAlert = false
    @State private var showOverflowMenu = false
    
    let languages = ["English", "Tiếng Việt", "ไทย", "Español", "Português", "中文"]
    
    var body: some View {
        NavigationView {
            ZStack {
                DeadShotGamesTheme.backgroundPrimary
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        // Header & Device / Version Area
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("DeadShotGames")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundColor(DeadShotGamesTheme.textPrimary)
                                
                                HStack(spacing: 8) {
                                    HStack(spacing: 4) {
                                        Circle()
                                            .fill(DeadShotGamesTheme.statusActive)
                                            .frame(width: 6, height: 6)
                                        Text("DSv2.5 • iPhone 15 Pro")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(DeadShotGamesTheme.textSecondary)
                                    }
                                    
                                    Text("•")
                                        .foregroundColor(DeadShotGamesTheme.textTertiary)
                                    
                                    Text("Connected")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(DeadShotGamesTheme.statusActive)
                                }
                            }
                            
                            Spacer()
                            
                            // Top Controls (Language & Overflow Menu)
                            HStack(spacing: 12) {
                                // Language Selector Button
                                Menu {
                                    ForEach(languages, id: \.self) { lang in
                                        Button(action: { selectedLanguage = lang }) {
                                            HStack {
                                                Text(lang)
                                                if selectedLanguage == lang {
                                                    Image(systemName: "checkmark")
                                                }
                                            }
                                        }
                                    }
                                } label: {
                                    HStack(spacing: 4) {
                                        Image(systemName: "globe")
                                            .font(.system(size: 13))
                                        Text(selectedLanguage.prefix(3).uppercased())
                                            .font(.system(size: 12, weight: .bold))
                                    }
                                    .foregroundColor(DeadShotGamesTheme.textPrimary)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 8)
                                    .background(DeadShotGamesTheme.backgroundTertiary)
                                    .cornerRadius(DeadShotGamesTheme.cornerRadiusSmall)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusSmall)
                                            .stroke(DeadShotGamesTheme.separator, lineWidth: 0.5)
                                    )
                                }
                                
                                // Overflow Menu Button
                                Menu {
                                    Button(action: {}) {
                                        Label("Check for Updates", systemImage: "arrow.clockwise")
                                    }
                                    Button(action: {}) {
                                        Label("Clear Cache", systemImage: "trash")
                                    }
                                    Button(action: {}) {
                                        Label("Diagnostic Logs", systemImage: "doc.text")
                                    }
                                    Divider()
                                    Button(action: {}) {
                                        Label("About DSGames", systemImage: "info.circle")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(DeadShotGamesTheme.textSecondary)
                                        .frame(width: 36, height: 36)
                                        .background(DeadShotGamesTheme.backgroundTertiary)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(DeadShotGamesTheme.separator, lineWidth: 0.5)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal, 4)
                        
                        // Choose a Game Section Header
                        HStack {
                            Text("CHOOSE A GAME")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(DeadShotGamesTheme.textSecondary)
                                .tracking(1.2)
                            
                            Spacer()
                            
                            Text("\(games.count) Available")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(DeadShotGamesTheme.textTertiary)
                        }
                        .padding(.horizontal, 4)
                        .padding(.top, 4)
                        
                        // Game Rows List
                        VStack(spacing: 12) {
                            ForEach($games) { $game in
                                GameRowView(
                                    game: game,
                                    onPlayTapped: {
                                        // Trigger direct launch / injection
                                        selectedGame = game
                                    },
                                    onInfoTapped: {
                                        infoGame = game
                                    },
                                    onSettingsTapped: {
                                        selectedGame = game
                                    }
                                )
                            }
                        }
                    }
                    .padding(16)
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $infoGame) { game in
                GameInfoSheet(game: game)
            }
            .background(
                NavigationLink(
                    destination: Group {
                        if let selectedGame = selectedGame,
                           let index = games.firstIndex(where: { $0.id == selectedGame.id }) {
                            GameSettingsView(game: $games[index])
                        } else {
                            EmptyView()
                        }
                    },
                    isActive: Binding(
                        get: { selectedGame != nil && infoGame == nil },
                        set: { if !$0 { selectedGame = nil } }
                    )
                ) {
                    EmptyView()
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.dark)
    }
}
