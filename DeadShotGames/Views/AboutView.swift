import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                DeadShotGamesTheme.backgroundPrimary
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Skull Logo Emblem
                        ZStack {
                            Circle()
                                .fill(DeadShotGamesTheme.accentRedGradient)
                                .frame(width: 90, height: 90)
                            
                            Image(systemName: "scope")
                                .font(.system(size: 45))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 6) {
                            Text("DeadShotGames")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(DeadShotGamesTheme.textPrimary)
                            
                            Text("DSv2.5 • Modpack v0.3")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(DeadShotGamesTheme.accentRed)
                            
                            Text("Build 2024.11.19 | iOS 16.1+")
                                .font(.system(size: 12))
                                .foregroundColor(DeadShotGamesTheme.textSecondary)
                        }
                        
                        VStack(alignment: .leading, spacing: 14) {
                            Text("SYSTEM SPECIFICATIONS")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(DeadShotGamesTheme.textSecondary)
                                .tracking(1.1)
                            
                            AboutInfoRow(title: "Architecture", value: "ARM64e / Kernel Allproc")
                            AboutInfoRow(title: "Memory Engine", value: "xpf_find_allproc active")
                            AboutInfoRow(title: "ESP Framework", value: "Metal / CoreAnimation Overlay")
                            AboutInfoRow(title: "Stealth Status", value: "Bypassed (Sandbox Escaped)")
                        }
                        .padding(16)
                        .background(DeadShotGamesTheme.cardBackground)
                        .cornerRadius(DeadShotGamesTheme.cornerRadiusCard)
                        .overlay(
                            RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusCard)
                                .stroke(DeadShotGamesTheme.separator, lineWidth: 0.5)
                        )
                        .padding(.horizontal, 16)
                        
                        Text("© 2024 DeadShotGames Studio. All rights reserved.")
                            .font(.system(size: 11))
                            .foregroundColor(DeadShotGamesTheme.textTertiary)
                            .padding(.bottom, 30)
                    }
                }
            }
            .navigationTitle("About DSGames")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(DeadShotGamesTheme.accentRed)
                    .font(.system(size: 16, weight: .semibold))
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct AboutInfoRow: View {
    let title: String
    let value: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(DeadShotGamesTheme.textSecondary)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(DeadShotGamesTheme.textPrimary)
        }
    }
}
