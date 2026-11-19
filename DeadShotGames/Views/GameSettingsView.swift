import SwiftUI

struct GameSettingsView: View {
    @Binding var game: GameItem
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var coordinator: ServicesCoordinator

    private var memoryEngine: MemoryEngine { coordinator.memoryEngine }
    private var espOverlayService: ESPOverlayService { coordinator.espOverlayService }
    private var stealthService: StealthService { coordinator.stealthService }

    @State private var showInjectionAlert = false
    @State private var injectionStatusMessage = ""
    @State private var injectionStatus: String = "Ready"

    var body: some View {
        ZStack {
            DeadShotGamesTheme.backgroundPrimary
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    headerSection
                    espSettingsSection
                    aimSettingsSection
                    statusSection
                    launchButton
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
        .alert(isPresented: $showInjectionAlert) {
            Alert(
                title: Text("Injection Active"),
                message: Text(injectionStatusMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .onDisappear {
            // Cleanup overlay if it was left attached when leaving settings.
            if espOverlayService.isOverlayActive {
                espOverlayService.detachOverlay()
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                ZStack {
                    RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusMedium)
                        .fill(DeadShotGamesTheme.backgroundTertiary)
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: game.iconName)
                        .font(.system(size: 28))
                        .foregroundColor(DeadShotGamesTheme.accentRed)
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
                        Text("DS Core v2.5 (KRW Active)")
                            .font(.system(size: 12))
                            .foregroundColor(DeadShotGamesTheme.statusActive)
                    }
                }
                
                Spacer()
            }
        }
        .padding(16)
        .dsCardStyle()
    }
    
    private var espSettingsSection: some View {
        SettingsSectionView(title: "ESP Settings", subtitle: "ScannerController, ESPReader & Renderer") {
            Toggle("Box", isOn: $game.settings.isBoxEnabled)
                .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentRed))
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(DeadShotGamesTheme.textPrimary)
                .onChange(of: game.settings) { newSettings in
                    if espOverlayService.isOverlayActive {
                        espOverlayService.updateESPSettings(newSettings)
                    }
                }
            
            Divider().background(DeadShotGamesTheme.separator)
            
            Toggle("Line", isOn: $game.settings.isLineEnabled)
                .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentRed))
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(DeadShotGamesTheme.textPrimary)
                .onChange(of: game.settings) { newSettings in
                    if espOverlayService.isOverlayActive {
                        espOverlayService.updateESPSettings(newSettings)
                    }
                }
            
            Divider().background(DeadShotGamesTheme.separator)
            
            Toggle("HP", isOn: $game.settings.isHpEnabled)
                .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentRed))
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(DeadShotGamesTheme.textPrimary)
                .onChange(of: game.settings) { newSettings in
                    if espOverlayService.isOverlayActive {
                        espOverlayService.updateESPSettings(newSettings)
                    }
                }
            
            Divider().background(DeadShotGamesTheme.separator)
            
            Toggle("Distance", isOn: $game.settings.isDistanceEnabled)
                .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentRed))
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(DeadShotGamesTheme.textPrimary)
                .onChange(of: game.settings) { newSettings in
                    if espOverlayService.isOverlayActive {
                        espOverlayService.updateESPSettings(newSettings)
                    }
                }
            
            Divider().background(DeadShotGamesTheme.separator)
            
            Toggle("Name", isOn: $game.settings.isNameEnabled)
                .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentRed))
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(DeadShotGamesTheme.textPrimary)
                .onChange(of: game.settings) { newSettings in
                    if espOverlayService.isOverlayActive {
                        espOverlayService.updateESPSettings(newSettings)
                    }
                }
        }
    }
    
    private var aimSettingsSection: some View {
        SettingsSectionView(title: "Aim Settings", subtitle: "applyAimToLocalPawn & RemoteCall") {
            Toggle("Enable Aim", isOn: $game.settings.isAimEnabled)
                .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentRed))
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(DeadShotGamesTheme.textPrimary)
                .onChange(of: game.settings) { newSettings in
                    if espOverlayService.isOverlayActive {
                        espOverlayService.updateESPSettings(newSettings)
                    }
                }
            
            Divider().background(DeadShotGamesTheme.separator)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("FOV Slider")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(DeadShotGamesTheme.textPrimary)
                    Spacer()
                    Text("\(Int(game.settings.fov))°")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(DeadShotGamesTheme.accentRed)
                }
                
                Slider(value: $game.settings.fov, in: 10...360, step: 1)
                    .accentColor(DeadShotGamesTheme.accentRed)
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
    }
    
    private var statusSection: some View {
        SettingsSectionView(title: "Backend & Stealth Status", subtitle: "xpf, CoreTrust, and Mach Ports") {
            HStack {
                Text("KRW Primitive")
                Spacer()
                Text(memoryEngine.isConnectedToKernel ? "Active" : "Unbound")
                    .foregroundColor(memoryEngine.isConnectedToKernel ? DeadShotGamesTheme.statusActive : DeadShotGamesTheme.statusInactive)
            }
            Divider().background(DeadShotGamesTheme.separator)
            HStack {
                Text("CoreTrust / AMFI Bypass")
                Spacer()
                Text(stealthService.coreTrustBypassed ? "Bypassed" : "Locked")
                    .foregroundColor(DeadShotGamesTheme.statusActive)
            }
            Divider().background(DeadShotGamesTheme.separator)
            HStack {
                Text("Sandbox Escape (.rooootwashere)")
                Spacer()
                Text(stealthService.sandboxEscaped ? "Escaped" : "Sandboxed")
                    .foregroundColor(DeadShotGamesTheme.statusActive)
            }
            Divider().background(DeadShotGamesTheme.separator)
            HStack {
                Text("Overlay")
                Spacer()
                Text(espOverlayService.isOverlayActive ? "Active" : "Detached")
                    .foregroundColor(DeadShotGamesTheme.statusActive)
            }
            Divider().background(DeadShotGamesTheme.separator)
            HStack {
                Text("ESP Status")
                Spacer()
                Text(espOverlayService.espStatus)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(espOverlayService.isOverlayActive ? DeadShotGamesTheme.statusActive : DeadShotGamesTheme.textSecondary)
            }
            Divider().background(DeadShotGamesTheme.separator)
            HStack {
                Text("Aimbot")
                Spacer()
                Text(espOverlayService.aimbotStatus)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(espOverlayService.isOverlayActive ? DeadShotGamesTheme.statusActive : DeadShotGamesTheme.textSecondary)
            }
            if memoryEngine.isConnectedToKernel {
                Divider().background(DeadShotGamesTheme.separator)
                HStack {
                    Text("Last Operation")
                    Spacer()
                    Text(memoryEngine.lastOperation)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(DeadShotGamesTheme.textSecondary)
                }
            }
        }
    }
    
    private var launchButton: some View {
        Button(action: {
            performInjectionFlow()
        }) {
            HStack {
                Image(systemName: injectionStatus == "Complete" ? "checkmark.circle.fill" : "bolt.fill")
                Text(injectionStatus == "Complete" ? "INJECTION ACTIVE" : "LAUNCH WITH INJECTION")
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(DeadShotGamesTheme.accentRedGradient)
            .cornerRadius(DeadShotGamesTheme.cornerRadiusMedium)
            .shadow(color: DeadShotGamesTheme.accentRed.opacity(0.4), radius: 8, x: 0, y: 4)
        }
        .padding(.top, 10)
    }
    
    private func performInjectionFlow() {
        injectionStatus = "Starting..."
        
        // Step 1: Initialize stealth
        stealthService.initializeStealth()
        
        // Step 2: Initialize KRW
        memoryEngine.initializeKRW()
        
        // Step 3: Attach overlay
        espOverlayService.attachOverlay(toGame: game.name, settings: game.settings)
        
        // Step 4: If overlay attached, try to read memory to verify connection
        if espOverlayService.isOverlayActive && memoryEngine.isConnectedToKernel {
            let health = memoryEngine.readPlayerHealth()
            let target = memoryEngine.readAimTarget()
            print("[DEBUG-integration] Read back: health=\(health) aimTarget=\(target)")
        }
        
        injectionStatus = "Complete"
        injectionStatusMessage = "Successfully injected into \(game.name) via RemoteCall & SpringBoard IOSurface! \(espOverlayService.espStatus) | \(espOverlayService.aimbotStatus)"
        showInjectionAlert = true
        DiagnosticLogger.shared.log("SUCCESS", "Injected \(game.name) — \(espOverlayService.espStatus) | \(espOverlayService.aimbotStatus)")
    }
}