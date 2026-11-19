import SwiftUI

struct AppsListView: View {
    @State private var apps: [AppItem] = AppItem.sampleApps
    @State private var searchText: String = ""
    @State private var selectedCategory: String = "All"
    
    let categories = ["All", "Utilities", "Gaming", "Network", "Monitoring", "Automation"]
    
    var filteredApps: [AppItem] {
        apps.filter { app in
            let matchesSearch = searchText.isEmpty ||
                app.name.localizedStandardContains(searchText) ||
                app.bundleId.localizedStandardContains(searchText)
            
            let matchesCategory = selectedCategory == "All" || app.category == selectedCategory
            
            return matchesSearch && matchesCategory
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                DeadShotGamesTheme.backgroundPrimary
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    // Header & Search
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Apps & Tools")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundColor(DeadShotGamesTheme.textPrimary)
                                
                                Text("Manage system utilities and app integrations")
                                    .font(.system(size: 13))
                                    .foregroundColor(DeadShotGamesTheme.textSecondary)
                            }
                            Spacer()
                        }
                        
                        // Search Bar
                        AppSearchBar(text: $searchText, placeholder: "Search app name or bundle ID...")
                        
                        // Category Filter Chips
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(categories, id: \.self) { category in
                                    Button(action: { selectedCategory = category }) {
                                        Text(category)
                                            .font(.system(size: 13, weight: .medium))
                                            .foregroundColor(selectedCategory == category ? .white : DeadShotGamesTheme.textSecondary)
                                            .padding(.horizontal, 14)
                                            .padding(.vertical, 7)
                                            .background(
                                                selectedCategory == category ?
                                                AnyView(DeadShotGamesTheme.accentBlueGradient) :
                                                AnyView(DeadShotGamesTheme.backgroundTertiary)
                                            )
                                            .cornerRadius(20)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(selectedCategory == category ? Color.clear : DeadShotGamesTheme.separator, lineWidth: 0.5)
                                            )
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    // App List
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            if filteredApps.isEmpty {
                                VStack(spacing: 12) {
                                    Image(systemName: "magnifyingglass")
                                        .font(.system(size: 36))
                                        .foregroundColor(DeadShotGamesTheme.textTertiary)
                                        .padding(.top, 40)
                                    
                                    Text("No matching apps found")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(DeadShotGamesTheme.textPrimary)
                                    
                                    Text("Try searching with a different keyword or bundle ID.")
                                        .font(.system(size: 13))
                                        .foregroundColor(DeadShotGamesTheme.textSecondary)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(32)
                            } else {
                                ForEach($apps) { $app in
                                    if filteredApps.contains(where: { $0.id == app.id }) {
                                        AppRowView(app: $app)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.dark)
    }
}

struct AppRowView: View {
    @Binding var app: AppItem
    
    var body: some View {
        HStack(spacing: 14) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusSmall)
                    .fill(DeadShotGamesTheme.backgroundTertiary)
                    .frame(width: 48, height: 48)
                
                Image(systemName: app.iconName)
                    .font(.system(size: 22))
                    .foregroundColor(DeadShotGamesTheme.accentBlue)
            }
            .overlay(
                RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusSmall)
                    .stroke(DeadShotGamesTheme.separator, lineWidth: 0.5)
            )
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(app.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(DeadShotGamesTheme.textPrimary)
                    .lineLimit(1)
                
                Text(app.bundleId)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(DeadShotGamesTheme.textSecondary)
                    .lineLimit(1)
                
                Text(app.category)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(DeadShotGamesTheme.accentBlue)
                    .padding(.top, 2)
            }
            
            Spacer()
            
            // Selection Toggle Button
            Button(action: {
                app.isSelected.toggle()
            }) {
                Image(systemName: app.isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(app.isSelected ? DeadShotGamesTheme.statusActive : DeadShotGamesTheme.textSecondary)
            }
        }
        .padding(14)
        .dsCardStyle()
    }
}
