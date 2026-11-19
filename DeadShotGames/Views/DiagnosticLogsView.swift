import SwiftUI

struct DiagnosticLogsView: View {
    @ObservedObject var logger = DiagnosticLogger.shared
    @Environment(\.presentationMode) var presentationMode
    @State private var showShareSheet = false
    @State private var exportedFilePath: URL?
    
    var body: some View {
        NavigationView {
            ZStack {
                DeadShotGamesTheme.backgroundPrimary
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Controls Bar
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Internal Telemetry")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(DeadShotGamesTheme.textPrimary)
                            Text("\(logger.logs.count) events recorded since launch")
                                .font(.system(size: 11))
                                .foregroundColor(DeadShotGamesTheme.textSecondary)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            generateAndShareReport()
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 13, weight: .bold))
                                Text("Export Diagnostics")
                                    .font(.system(size: 13, weight: .bold))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(DeadShotGamesTheme.accentRed)
                            .cornerRadius(DeadShotGamesTheme.cornerRadiusSmall)
                        }
                    }
                    .padding(16)
                    .background(DeadShotGamesTheme.backgroundSecondary)
                    
                    Divider()
                        .background(DeadShotGamesTheme.separator)
                    
                    // Logs List
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 8) {
                            ForEach(logger.logs) { log in
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack(spacing: 8) {
                                        Text(log.formattedTime)
                                            .font(.system(size: 11, design: .monospaced))
                                            .foregroundColor(DeadShotGamesTheme.textTertiary)
                                        
                                        Text(log.level)
                                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 6)
                                            .padding(.vertical, 2)
                                            .background(badgeColor(for: log.level))
                                            .cornerRadius(4)
                                        
                                        Spacer()
                                    }
                                    
                                    Text(log.message)
                                        .font(.system(size: 12, design: .monospaced))
                                        .foregroundColor(DeadShotGamesTheme.textPrimary)
                                        .textSelection(.enabled)
                                }
                                .padding(12)
                                .background(DeadShotGamesTheme.cardBackground)
                                .cornerRadius(DeadShotGamesTheme.cornerRadiusSmall)
                                .overlay(
                                    RoundedRectangle(cornerRadius: DeadShotGamesTheme.cornerRadiusSmall)
                                        .stroke(DeadShotGamesTheme.separator, lineWidth: 0.5)
                                )
                            }
                        }
                        .padding(16)
                    }
                }
            }
            .navigationTitle("Diagnostic Logs")
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
            .sheet(isPresented: $showShareSheet) {
                if let url = exportedFilePath {
                    ShareSheet(activityItems: [url])
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func badgeColor(for level: String) -> Color {
        switch level {
        case "INIT": return DeadShotGamesTheme.accentRed
        case "KERNEL": return Color.purple
        case "SECURITY": return Color.orange
        case "OVERLAY": return Color.blue
        case "ACTION": return DeadShotGamesTheme.statusActive
        case "SUCCESS": return DeadShotGamesTheme.statusActive
        default: return DeadShotGamesTheme.textSecondary
        }
    }
    
    private func generateAndShareReport() {
        let text = logger.exportText()
        let fileName = "DeadShotGames_Diagnostics_\(Int(Date().timeIntervalSince1970)).txt"
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        try? text.write(to: tempURL, atomically: true, encoding: .utf8)
        exportedFilePath = tempURL
        showShareSheet = true
        DiagnosticLogger.shared.log("ACTION", "Exported diagnostic logs to \(fileName)")
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
