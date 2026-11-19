import SwiftUI

struct GameSettingsView: View {
    @Binding var game: GameItem
    @Environment(\.dismiss) private var dismiss
    @State private var showSaved = false

    var body: some View {
        ZStack {
            DeadShotGamesTheme.backgroundPrimary.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 18) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 14) {
                            Image(systemName: game.iconName)
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(DeadShotGamesTheme.accentBlue)
                                .frame(width: 58, height: 58)
                                .background(DeadShotGamesTheme.backgroundTertiary)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            VStack(alignment: .leading, spacing: 5) {
                                Text(game.name).font(.title3.bold()).foregroundColor(DeadShotGamesTheme.textPrimary)
                                Text(game.subtitle).font(.caption).foregroundColor(DeadShotGamesTheme.textSecondary)
                                GameStatusView(status: game.status)
                            }
                            Spacer()
                        }
                    }
                    .padding(16)
                    .dsCardStyle()

                    SettingsSectionView(title: "ESP Settings", subtitle: "Display preferences") {
                        settingToggle("Box", value: $game.settings.isBoxEnabled)
                        Divider().background(DeadShotGamesTheme.separator)
                        settingToggle("Line", value: $game.settings.isLineEnabled)
                        Divider().background(DeadShotGamesTheme.separator)
                        settingToggle("HP", value: $game.settings.isHpEnabled)
                        Divider().background(DeadShotGamesTheme.separator)
                        settingToggle("Distance", value: $game.settings.isDistanceEnabled)
                        Divider().background(DeadShotGamesTheme.separator)
                        settingToggle("Name", value: $game.settings.isNameEnabled)
                    }

                    SettingsSectionView(title: "Aim Controls", subtitle: "Configuration preferences") {
                        settingToggle("Enable Aim", value: $game.settings.isAimEnabled)
                        Divider().background(DeadShotGamesTheme.separator)
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("FOV").foregroundColor(DeadShotGamesTheme.textPrimary)
                                Spacer()
                                Text("\(Int(game.settings.fov))°")
                                    .fontWeight(.semibold)
                                    .foregroundColor(DeadShotGamesTheme.accentBlue)
                            }
                            Slider(value: $game.settings.fov, in: 10...360, step: 1)
                                .tint(DeadShotGamesTheme.accentBlue)
                        }
                        Divider().background(DeadShotGamesTheme.separator)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Aim Type").foregroundColor(DeadShotGamesTheme.textPrimary)
                            Picker("Aim Type", selection: $game.settings.aimType) {
                                ForEach(AimType.allCases) { Text($0.rawValue).tag($0) }
                            }
                            .pickerStyle(.segmented)
                        }
                        Divider().background(DeadShotGamesTheme.separator)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Aim When").foregroundColor(DeadShotGamesTheme.textPrimary)
                            Picker("Aim When", selection: $game.settings.aimWhen) {
                                ForEach(AimWhen.allCases) { Text($0.rawValue).tag($0) }
                            }
                            .pickerStyle(.segmented)
                        }
                    }

                    Button {
                        showSaved = true
                    } label: {
                        Label("Save Configuration", systemImage: "checkmark.circle.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(DeadShotGamesTheme.accentBlueGradient)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(16)
            }
        }
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Close") { dismiss() }
                    .foregroundColor(DeadShotGamesTheme.textSecondary)
            }
        }
        .alert("Configuration Saved", isPresented: $showSaved) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Your settings have been saved for this session.")
        }
        .preferredColorScheme(.dark)
    }

    private func settingToggle(_ title: String, value: Binding<Bool>) -> some View {
        Toggle(title, isOn: value)
            .tint(DeadShotGamesTheme.accentBlue)
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(DeadShotGamesTheme.textPrimary)
    }
}
