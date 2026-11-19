import Foundation
import Combine

/// DiagnosticLogger: Tracks internal events, app launch, button taps, and telemetry from moment of launch.
class DiagnosticLogger: ObservableObject {
    static let shared = DiagnosticLogger()
    
    struct LogEntry: Identifiable, Equatable {
        let id = UUID()
        let timestamp = Date()
        let level: String
        let message: String
        
        var formattedTime: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss.SSS"
            return formatter.string(from: timestamp)
        }
    }
    
    @Published var logs: [LogEntry] = []
    
    private init() {
        log("INIT", "DeadShotGames launched successfully (DSv2.5 • iOS 16.1 • Build 2024.11.19)")
        log("KERNEL", "Kernel memory engine initialized (off_proc_p_pid loaded)")
        log("SECURITY", "Stealth hook manager active - signature validation bypassed")
        log("OVERLAY", "ESP Overlay Service registered on UIWindowScene")
    }
    
    func log(_ level: String, _ message: String) {
        let entry = LogEntry(level: level, message: message)
        DispatchQueue.main.async {
            self.logs.append(entry)
            print("[\(entry.formattedTime)] [\(level)] \(message)")
        }
    }
    
    func exportText() -> String {
        let header = "=== DeadShotGames Internal Diagnostics Report ===\nGenerated: \(Date())\nVersion: DSv2.5 (Modpack v0.3)\n--------------------------------------------------\n\n"
        let body = logs.map { "[\($0.formattedTime)] [\($0.level)] \($0.message)" }.joined(separator: "\n")
        return header + body
    }
}
