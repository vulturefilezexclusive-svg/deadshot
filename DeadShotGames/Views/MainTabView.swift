import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0

    init() {
        // Customize Tab Bar appearance for OLED Black & F1 Red theme
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(DeadShotGamesTheme.backgroundSecondary)
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(DeadShotGamesTheme.accentRed)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(DeadShotGamesTheme.accentRed)]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(DeadShotGamesTheme.textSecondary)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(DeadShotGamesTheme.textSecondary)]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            GamesDashboardView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller.fill")
                }
                .tag(0)

            AppsListView()
                .tabItem {
                    Label("Apps", systemImage: "square.grid.2x2.fill")
                }
                .tag(1)
        }
        .accentColor(DeadShotGamesTheme.accentRed)
        .preferredColorScheme(.dark)
    }
}
