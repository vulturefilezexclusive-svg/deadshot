import Foundation

/// MemoryEngine: Handles KRW Primitive kernel read/write via darksword Mach ports,
/// RemoteCall thread injection for memory writes, and DSGamesAppDecrypt FairPlay dumping.
class MemoryEngine: ObservableObject {
    @Published var isConnectedToKernel: Bool = false
    @Published var activePortStatus: String = "krw.darksword.control_port: Unbound"
    @Published var lastOperation: String = "None"

    /// Simulated kernel address space. Keys are virtual addresses, values are backing bytes.
    private var memorySpace: [UInt64: Data] = [:]

    /// Known offsets used by the DSGames v2.5 runtime (simulated).
    struct KnownAddress {
        static let localHealth: UInt64 = 0x1_0000_0000
        static let localPosition: UInt64 = 0x1_0000_0008
        static let aimTarget: UInt64 = 0x1_0000_0018
    }

    /// Initialize darksword Mach control ports and kernel slide.
    func initializeKRW() {
        print("[DEBUG-krw] Initializing krw.darksword.control_port / rw_port")
        // Seed the simulated memory space with plausible game values.
        var health: Int32 = 100
        memorySpace[KnownAddress.localHealth] = Data(bytes: &health, count: MemoryLayout<Int32>.size)
        var position: UInt64 = 0x0042_4800
        memorySpace[KnownAddress.localPosition] = Data(bytes: &position, count: MemoryLayout<UInt64>.size)
        var target: UInt64 = 0
        memorySpace[KnownAddress.aimTarget] = Data(bytes: &target, count: MemoryLayout<UInt64>.size)

        isConnectedToKernel = true
        activePortStatus = "krw.darksword.control_port: Active (Slide: 0x1f4a000)"
        lastOperation = "KRW initialized (off_proc_p_pid loaded)"
    }

    /// Read memory via mach_vm_read_overwrite.
    func readMemory(address: UInt64, size: Int) -> Data {
        let hex = String(address, radix: 16)
        if let backing = memorySpace[address] {
            print("[DEBUG-mach_vm_read_overwrite] Read \(min(size, backing.count)) bytes from 0x\(hex)")
            lastOperation = "Read \(size) bytes @ 0x\(hex)"
            return backing.prefix(size)
        }
        print("[DEBUG-mach_vm_read_overwrite] Read \(size) bytes from 0x\(hex) (unmapped)")
        lastOperation = "Read \(size) bytes @ 0x\(hex) (unmapped)"
        return Data(repeating: 0x00, count: size)
    }

    /// Write memory via RemoteCall (thread hijacking & execution inside target process).
    func writeMemoryRemoteCall(address: UInt64, data: Data) -> Bool {
        let hex = String(address, radix: 16)
        print("[DEBUG-RemoteCall] thread_create + thread_set_state + thread_resume for write at 0x\(hex)")
        memorySpace[address] = data
        lastOperation = "Wrote \(data.count) bytes @ 0x\(hex)"
        return true
    }

    /// Read the local player's health value from simulated kernel memory.
    func readPlayerHealth() -> Int32 {
        let data = readMemory(address: KnownAddress.localHealth, size: MemoryLayout<Int32>.size)
        guard data.count == MemoryLayout<Int32>.size else { return 0 }
        return data.withUnsafeBytes { $0.load(as: Int32.self) }
    }

    /// Write the local player's health value into simulated kernel memory.
    @discardableResult
    func writePlayerHealth(_ health: Int32) -> Bool {
        var value = health
        let data = Data(bytes: &value, count: MemoryLayout<Int32>.size)
        return writeMemoryRemoteCall(address: KnownAddress.localHealth, data: data)
    }

    /// Read the current aim target pointer from simulated kernel memory.
    func readAimTarget() -> UInt64 {
        let data = readMemory(address: KnownAddress.aimTarget, size: MemoryLayout<UInt64>.size)
        guard data.count == MemoryLayout<UInt64>.size else { return 0 }
        return data.withUnsafeBytes { $0.load(as: UInt64.self) }
    }

    /// Write the aim target pointer into simulated kernel memory (RemoteCall path).
    @discardableResult
    func writeAimTarget(_ target: UInt64) -> Bool {
        var value = target
        let data = Data(bytes: &value, count: MemoryLayout<UInt64>.size)
        return writeMemoryRemoteCall(address: KnownAddress.aimTarget, data: data)
    }

    /// Release the kernel connection and clear the simulated memory space.
    func disconnectKRW() {
        memorySpace.removeAll()
        isConnectedToKernel = false
        activePortStatus = "krw.darksword.control_port: Unbound"
        lastOperation = "KRW disconnected"
        print("[DEBUG-krw] Released krw.darksword.control_port")
    }

    /// DSGamesAppDecrypt: Dump decrypted pages and repackage target IPA.
    func decryptAndDumpApp(bundleId: String, completion: @escaping (Bool, String) -> Void) {
        print("[DEBUG-DSGamesAppDecrypt] Starting FairPlay decryption for \(bundleId)")
        lastOperation = "Decrypting \(bundleId)"
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.2) {
            DispatchQueue.main.async {
                completion(true, "/private/var/mobile/Documents/Decrypted-\(bundleId).ipa")
            }
        }
    }
}
