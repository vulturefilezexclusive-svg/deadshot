import Foundation

/// ProcessManager: Handles process discovery, kernel allproc walking (xpf_find_allproc),
/// PID listing, and task acquisition for target games (e.g., CODM, Free Fire, Wild Rift).
class ProcessManager: ObservableObject {
    @Published var activeProcesses: [DiscoveredProcess] = []
    @Published var isScanning: Bool = false
    @Published var kernelStatus: String = "Kernel Uninitialized"
    @Published var lastScanMessage: String = "Not started"
    
    struct DiscoveredProcess: Identifiable, Equatable {
        let id: Int32 // PID
        let name: String
        let path: String
        let taskPort: UInt32
        let isTargetGame: Bool
    }
    
    /// Scan running processes (simulating proc_listpids, proc_pidpath, and kernel allproc offset traversal)
    func scanProcesses() {
        isScanning = true
        kernelStatus = "XPF Offset Table Loaded (off_proc_p_pid)"
        lastScanMessage = "Scanning for processes..."
        
        // Simulate discovery of running game processes and system tasks
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.6) {
            let discovered = [
                DiscoveredProcess(id: 412, name: "launchd", path: "/sbin/launchd", taskPort: 0x103, isTargetGame: false),
                DiscoveredProcess(id: 1042, name: "SpringBoard", path: "/System/Library/CoreServices/SpringBoard.app/SpringBoard", taskPort: 0x1a7, isTargetGame: false),
                DiscoveredProcess(id: 2041, name: "com.riotgames.league.wildrift", path: "/private/var/containers/Bundle/Application/WildRift.app/WildRift", taskPort: 0x403, isTargetGame: true),
                DiscoveredProcess(id: 2105, name: "com.dts.freefireth", path: "/private/var/containers/Bundle/Application/FreeFireTH.app/FreeFireTH", taskPort: 0x417, isTargetGame: true),
                DiscoveredProcess(id: 2188, name: "com.activision.callofduty.shooter", path: "/private/var/containers/Bundle/Application/CODM.app/CODM", taskPort: 0x503, isTargetGame: true),
            ]
            
            DispatchQueue.main.async {
                self.activeProcesses = discovered
                self.isScanning = false
                self.kernelStatus = "Kernel allproc Walk Complete (5 processes mapped)"
                self.lastScanMessage = "Process scan completed"
            }
        }
    }
    
    /// Simulate kernel memory task acquisition for target PID
    func acquireTask(forPid pid: Int32) -> UInt32 {
        print("[DEBUG-codm-task] acquire pid=\(pid) via task_for_pid / processor_set_tasks fallback")
        // Find the target game process
        if let target = activeProcesses.first(where: { $0.isTargetGame }) {
            return target.taskPort
        } else {
            print("[DEBUG] No target game found in activeProcesses")
            return 0
        }
    }
    
    /// Get the PID of a specific target game process by name
    func findPidByName(_ name: String) -> Int32? {
        return activeProcesses.first(where: { $0.name == name })?.id
    }
}