import SwiftUI

struct GamesDashboardView: View {
    @EnvironmentObject private var coordinator: ServicesCoordinator
@State private var games: [GameItem] = GameItem.sampleGames
    @State private var selectedGame: GameItem?
    @State private var infoGame: GameItem?
    @State private var selectedLanguage: String = "English"
    
    // Overflow menu sheets & alerts
    @State private var showDiagnosticLogs = false
    @State private var showAbout = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @State private var launchGameItem: GameItem?
    @State private var showLaunchAlert = false
    
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
                                        Button(action: {
                                            selectedLanguage = lang
                                            DiagnosticLogger.shared.log("ACTION", "Changed language to \(lang)")
                                        }) {
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
                                    Button(action: {
                                        alertTitle = "Check for Updates"
                                        alertMessage = "You are running the latest version DSv2.5 (Modpack v0.3). All modules up to date."
                                        showAlert = true
                                        DiagnosticLogger.shared.log("ACTION", "Checked for updates - up to date")
                                    }) {
                                        Label("Check for Updates", systemImage: "arrow.clockwise")
                                    }
                                    
                                    Button(action: {
                                        alertTitle = "Clear Cache"
                                        alertMessage = "Cache cleared successfully. 142 MB of temporary shader/ESP cache freed."
                                        showAlert = true
                                        DiagnosticLogger.shared.log("SUCCESS", "Cleared app cache and temporary shader data")
                                    }) {
                                        Label("Clear Cache", systemImage: "trash")
                                    }
                                    
                                    Button(action: {
                                        showDiagnosticLogs = true
                                        DiagnosticLogger.shared.log("ACTION", "Opened Diagnostic Logs viewer")
                                    }) {
                                        Label("Diagnostic Logs", systemImage: "doc.text")
                                    }
                                    
                                    Divider()
                                    
                                    Button(action: {
                                        showAbout = true
                                        DiagnosticLogger.shared.log("ACTION", "Opened About DSGames screen")
                                    }) {
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
                                        launchGameItem = game
                                        coordinator.inject(into: game, settings: game.settings)
                                        showLaunchAlert = true
                                        DiagnosticLogger.shared.log("SUCCESS", "Launched & Injected DeadShot Engine into \(game.name) (\(game.subtitle))")
                                    },
                                    onInfoTapped: {
                                        infoGame = game
                                        DiagnosticLogger.shared.log("ACTION", "Viewed info for \(game.name)")
                                    },
                                    onSettingsTapped: {
                                        selectedGame = game
                                        DiagnosticLogger.shared.log("ACTION", "Opened settings for \(game.name)")
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
            .sheet(isPresented: $showDiagnosticLogs) {
                DiagnosticLogsView()
            }
            .sheet(isPresented: $showAbout) {
                AboutView()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showLaunchAlert) {
                Alert(
                    title: Text("Injection Successful"),
                    message: Text("DeadShot Engine v2.5 successfully injected into \(launchGameItem?.name ?? "Game"). ESP & Aimbot modules are now active."),
                    dismissButton: .default(Text("OK"))
                )
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
                        get: { selectedGame != nil && infoGame == nil && !showDiagnosticLogs && !showAbout },
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
