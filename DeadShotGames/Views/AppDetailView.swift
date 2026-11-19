import SwiftUI

struct AppDetailView: View {
    @Binding var app: AppItem
    @Environment(\.presentationMode) var presentationMode
    @State private var showActionAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                DeadShotGamesTheme.backgroundPrimary
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Header Card
                        VStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusMedium)
                                    .fill(DeadShotGamesTheme.backgroundTertiary)
                                    .frame(width: 72, height: 72)
                                
                                Image(systemName: app.iconName)
                                    .font(.system(size: 34))
                                    .foregroundColor(DeadShotGamesTheme.accentRed)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusMedium)
                                    .stroke(DeadShotGamesTheme.separator, lineWidth: 0.5)
                            )
                            
                            Text(app.name)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(DeadShotGamesTheme.textPrimary)
                            
                            Text(app.bundleId)
                                .font(.system(size: 13, design: .monospaced))
                                .foregroundColor(DeadShotGamesTheme.textSecondary)
                            
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(app.isSelected ? DeadShotGamesTheme.statusActive : DeadShotGamesTheme.textTertiary)
                                    .frame(width: 8, height: 8)
                                Text(app.isSelected ? "Active & Hooked" : "Inactive")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(app.isSelected ? DeadShotGamesTheme.statusActive : DeadShotGamesTheme.textSecondary)
                            }
                            .padding(.top, 4)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(DeadShotGamesTheme.cardBackground)
                        .cornerRadius(DeadShotGamesTheme.cornerRadiusCard)
                        .overlay(
                            RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusCard)
                                .stroke(DeadShotGamesTheme.separator, lineWidth: 0.5)
                        )
                        .padding(.horizontal, 16)
                        
                        // Integration & Options Section
                        VStack(alignment: .leading, spacing: 14) {
                            Text("TOOL CONFIGURATION")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(DeadShotGamesTheme.textSecondary)
                                .tracking(1.1)
                            
                            Toggle(isOn: $app.isSelected) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Enable Integration")
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(DeadShotGamesTheme.textPrimary)
                                    Text("Allow DeadShot runtime hooks for \(app.name)")
                                        .font(.system(size: 12))
                                        .foregroundColor(DeadShotGamesTheme.textSecondary)
                                }
                            }
                            .toggleStyle(SwitchToggleStyle(tint: DeadShotGamesTheme.accentRed))
                            
                            Divider()
                                .background(DeadShotGamesTheme.separator)
                            
                            Button(action: {
                                alertMessage = "Successfully re-injected runtime hooks for \(app.name)."
                                showActionAlert = true
                                DiagnosticLogger.shared.log("ACTION", "Re-injected utility: \(app.name)")
                            }) {
                                HStack {
                                    Label("Re-initialize Runtime Hooks", systemImage: "arrow.clockwise.circle")
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(DeadShotGamesTheme.textPrimary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 13))
                                        .foregroundColor(DeadShotGamesTheme.textTertiary)
                                }
                            }
                            
                            Divider()
                                .background(DeadShotGamesTheme.separator)
                            
                            Button(action: {
                                alertMessage = "Cleared cache & local state for \(app.name)."
                                showActionAlert = true
                                DiagnosticLogger.shared.log("ACTION", "Cleared cache for utility: \(app.name)")
                            }) {
                                HStack {
                                    Label("Clear Tool Cache & Temp Data", systemImage: "trash")
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(DeadShotGamesTheme.statusInactive)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 13))
                                        .foregroundColor(DeadShotGamesTheme.textTertiary)
                                }
                            }
                        }
                        .padding(16)
                        .background(DeadShotGamesTheme.cardBackground)
                        .cornerRadius(DeadShotGamesTheme.cornerRadiusCard)
                        .overlay(
                            RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusCard)
                                .stroke(DeadShotGamesTheme.separator, lineWidth: 0.5)
                        )
                        .padding(.horizontal, 16)
                    }
                    .padding(.top, 16)
                }
            }
            .navigationTitle("Tool Management")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(DeadShotGamesTheme.accentRed)
                    .font(.system(size: 16, weight: .semibold))
                }
            }
            .alert(isPresented: $showActionAlert) {
                Alert(title: Text("Tool Action"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .preferredColorScheme(.dark)
    }
}
