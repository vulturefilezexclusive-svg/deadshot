# DeadShotGames-UI-Source (deadshot)

A modular, native SwiftUI iOS project (`DeadShotGames-UI-Source`) reproducing the interface structure, visual design, and core reverse-engineered backend architecture of the original DSGames v2.5 interface. Optimized for iOS 16.1+ and iPhone 15 dimensions with a dark-themed, premium aesthetic.

---

## Architecture & Project Structure

```
deadshot/
│
├── DeadShotGames/
│   ├── App/
│   │   └── DeadShotGamesApp.swift          # App entry point
│   │
│   ├── Views/
│   │   ├── MainTabView.swift               # Two-tab navigation (Games | Apps)
│   │   ├── GamesDashboardView.swift        # Games list, header, language selector, overflow menu
│   │   ├── AppsListView.swift              # Apps list, search bar, category filter
│   │   ├── GameSettingsView.swift          # Reusable game settings (ESP & Aim controls)
│   │   └── GameInfoSheet.swift             # Information modal sheet
│   │
│   ├── Components/
│   │   ├── GameRowView.swift               # Individual game row with play/info/settings
│   │   ├── GameStatusView.swift            # Colored status indicator badge
│   │   ├── AppSearchBar.swift              # Search field for app names / bundle IDs
│   │   └── SettingsSectionView.swift       # Reusable card container for settings sections
│   │
│   ├── Models/
│   │   ├── GameItem.swift                  # Game item model, status, and ESP/Aim settings structs
│   │   └── AppItem.swift                   # App item model and category data
│   │
│   ├── Services/                           # Core Backend & Integration Modules
│   │   ├── ProcessManager.swift            # PID enumeration, proc_listpids, xpf_find_allproc kernel walk
│   │   ├── MemoryEngine.swift              # KRWPrimitive Mach ports, mach_vm_read_overwrite, DSGamesAppDecrypt
│   │   ├── ESPOverlayService.swift         # ScannerController, RemoteCall thread hijacking, IOSurface window
│   │   └── StealthService.swift            # CoreTrust/AMFI bypass, sandbox escape, DoH DNS profile
│   │
│   ├── DesignSystem/
│   │   └── DeadShotGamesTheme.swift        # Dark theme color palette, gradients, typography, and card modifiers
│   │
│   └── Assets.xcassets/
│
├── README.md
└── .github/
    └── workflows/
        └── build.yml
```

---

## Mapped Core Functions & Integration Modules

### 1. Process Discovery & Kernel Walking (`ProcessManager`)
- Implements kernel allproc walking via `xpf_find_allproc` (traversing offset tables like `off_proc_p_pid`, `p_name`).
- Manages process enumeration via `proc_listpids` and `proc_pidpath`.
- Task acquisition: uses `task_for_pid` and fallbacks through `host_processor_set_priv` + `processor_set_tasks` (with CODM task logging).

### 2. Memory Engine & KRW Primitives (`MemoryEngine`)
- **KRW Primitive**: Communicates via darksword Mach control ports (`krw.darksword.control_port` / `rw_port`).
- **Memory Reads**: Uses `mach_vm_read_overwrite`.
- **Memory Writes**: Executes code inside target processes via `RemoteCall` thread injection (avoiding direct `mach_vm_write`).
- **FairPlay Decrypter**: Integrates `DSGamesAppDecrypt` architecture for dumping decrypted app pages and repackaging IPAs.

### 3. ESP & Aimbot Injection (`ESPOverlayService`)
- **Pipeline**: `ScannerController` (entity discovery) + `ESPReader` (data reading) + `ESPRenderer` (rendering).
- **Injection (`RemoteCall`)**: Hijacks target threads (`thread_create`, `thread_set_exception_ports`, `thread_resume`) or locates SpringBoard injectable threads on iOS 16.
- **Overlay Window**: Hosted via `SBSAccessibilityWindowHostingController` on an IOSurface shared surface using CGContext/Metal.
- **Aimbot**: Legit aim, silent aim (`applyAimToLocalPawn`, FOV/distance gating), and synthetic IOHID touch events lookup.

### 4. Anti-Detection & Stealth Layers (`StealthService`)
- Exploit init via `_xpf_start_with_kernel_path` and `_xpf_construct_offset_dictionary`.
- CoreTrust & AMFI bypass (load command rewriting for unsigned binary execution).
- Sandbox escape (clearing CrashReporter logs, marker file `/var/mobile/.rooootwashere`).
- Kernel label patching and DoH DNS profile telemetry filtering for FreeFire.

*(Note: No license or key checks are included in this build as requested.)*
