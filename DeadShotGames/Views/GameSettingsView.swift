import SwiftUI

struct GameSettingsView: View {
    @Binding var game: GameItem
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            DeadShotGamesTheme.backgroundPrimary
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header / Status Area
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .top) {
                            ZStack {
                                RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusMedium)
                                    .fill(DeadShotGamesTheme.backgroundTertiary)
                                    .frame(width: 56, height: 56)
                                
                                Image(systemName: game.iconName)
                                    .font(.system(size: 28))
                                    .foregroundColor(DeadShotGamesTheme.accentBlue)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(game.name)
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(DeadShotGamesTheme.textPrimary)
                                
                                Text(game.subtitle)
                                    .font(.system(size: 12))
                                    .foregroundColor(DeadShotGamesTheme.textSecondary)
                                
                                HStack(spacing: 8) {
                                    GameStatusView(status: game.status)
                                    Text("•")
                                        .foregroundColor(DeadShotGamesTheme.textTertiary)
                                    Text("Engine v2.5")
                                        .font(.system(size: 12))
                                        .foregroundColor(DeadShotGamesTheme.textSecondary)
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(16)
                    .dsCardStyle()
                    
                    // ESP Settings Section
                    SettingsSectionView(title: "ESP Settings", subtitle: "Visual overlay and target rendering") {
                        Toggle("Box", isOn: $game.settings.isBoxEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentBlue))
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(DeadShotGamesTheme.textPrimary)
                        
                        Divider().background(DeadShotGamesTheme.separator)
                        
                        Toggle("Line", isOn: $game.settings.isLineEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentBlue))
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(DeadShotGamesTheme.textPrimary)
                        
                        Divider().background(DeadShotGamesTheme.separator)
                        
                        Toggle("HP", isOn: $game.settings.isHpEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentBlue))
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(DeadShotGamesTheme.textPrimary)
                        
                        Divider().background(DeadShotGamesTheme.separator)
                        
                        Toggle("Distance", isOn: $game.settings.isDistanceEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentBlue))
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(DeadShotGamesTheme.textPrimary)
                        
                        Divider().background(DeadShotGamesTheme.separator)
                        
                        Toggle("Name", isOn: $game.settings.isNameEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentBlue))
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(DeadShotGamesTheme.textPrimary)
                    }
                    
                    // Aim Settings Section
                    SettingsSectionView(title: "Aim Settings", subtitle: "Target locking and field of view") {
                        Toggle("Enable Aim", isOn: $game.settings.isAimEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentBlue))
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(DeadShotGamesTheme.textPrimary)
                        
                        Divider().background(DeadShotGamesTheme.separator)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("FOV Slider")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(DeadShotGamesTheme.textPrimary)
                                Spacer()
                                Text("\(Int(game.settings.fov))°")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(DeadShotGamesTheme.accentBlue)
                            }
                            
                            Slider(value: $game.settings.fov, in: 10...360, step: 1)
                                .accentColor(DeadShotGamesTheme.accentBlue)
                        }
                        
                        Divider().background(DeadShotGamesTheme.separator)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Aim Type")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(DeadShotGamesTheme.textPrimary)
                            
                            Picker("Aim Type", selection: $game.settings.aimType) {
                                ForEach(AimType.allCases) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Divider().background(DeadShotGamesTheme.separator)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Aim When")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(DeadShotGamesTheme.textPrimary)
                            
                            Picker("Aim When", selection: $game.settings.aimWhen) {
                                ForEach(AimWhen.allCases) { when in
                                    Text(when.rawValue).tag(when)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    
                    // Bottom Action / Launch
                    Button(action: {
                        // Action trigger for starting injected game
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("LAUNCH WITH INJECTION")
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(DeadShotGamesTheme.accentBlueGradient)
                        .cornerRadius(DeadShotGamesTheme.cornerRadiusMedium)
                        .shadow(color: DeadShotGamesTheme.accentBlue.opacity(0.4), radius: 8, x: 0, y: 4)
                    }
                    .padding(.top, 10)
                }
                .padding(16)
            }
        }
        .navigationTitle(game.name)
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
        .preferredColorScheme(.dark)
    }
}
