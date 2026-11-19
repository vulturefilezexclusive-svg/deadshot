# DeadShotGames UI Source

A modular, native SwiftUI iOS project (`DeadShotGames-UI-Source`) reproducing the interface structure and visual design of the original DSGames v2.5 interface. Optimized for iOS 16.1+ and iPhone 15 dimensions with a dark-themed, premium aesthetic.

---

## Architecture & Project Structure

```
DeadShotGames-UI-Source/
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
│   │   ├── GameRowView.swift               # Individual game list row with play/info/settings
│   │   ├── GameStatusView.swift            # Colored status indicator badge
│   │   ├── AppSearchBar.swift              # Search field for app names / bundle IDs
│   │   └── SettingsSectionView.swift       # Reusable card container for settings sections
│   │
│   ├── Models/
│   │   ├── GameItem.swift                  # Game item model, status, and ESP/Aim settings structs
│   │   └── AppItem.swift                   # App item model and category data
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

## Key Features & UI Modules

### 1. Two-Tab Navigation (`MainTabView`)
- **Games Tab (`GamesDashboardView`)**: Displays the main DeadShotGames dashboard with device status (`DSv2.5 • iPhone 15 Pro`), language selector (English, Vietnamese, Thai, Spanish, Portuguese, Chinese), overflow maintenance menu, and the complete game catalog.
- **Apps Tab (`AppsListView`)**: Searchable app utility list with real-time name and bundle ID filtering, category chips, and selection toggles.

### 2. Game Selection Catalog
Includes all required game entries with status indicators and action buttons:
1. **Wild Rift DS** (`com.riotgames.league.wildrift`)
2. **Free Fire TH DS** (`com.dts.freefireth`)
3. **Free Fire MAX DS** (`com.dts.freefiremax`)
4. **CrossFire Mobile DS** (`com.tencent.tmgp.cf`)
5. **8 Ball Pool DS** (`com.miniclip.eightballpool`)
6. **Call of Duty Mobile VN DS** (`com.vng.codm`)
7. **Call of Duty Mobile Global DS** (`com.activision.callofduty.shooter`)

### 3. Reusable Game Settings Interface (`GameSettingsView`)
Adapts dynamically to the selected game, featuring:
- **Game Header & Status Area**: Icon, title, bundle ID, and active engine status.
- **ESP Settings Section**: Interactive toggles for `Box`, `Line`, `HP`, `Distance`, and `Name`.
- **Aim Settings Section**: `Enable Aim` toggle, FOV slider (10°–360°), `Aim Type` segmented control (`Head`, `Body`), and `Aim When` segmented control (`Always`, `Firing`).

### 4. Design System (`DeadShotGamesTheme`)
- **Dark Charcoal Backgrounds**: `#121216`, `#1C1C22`, `#1E1E26`
- **Vibrant iOS Blue Accents**: `#0A84FF` with custom linear gradients
- **Status Badges**: Active (`#30D158`), Updating (`#FFD60A`), Maintenance (`#FF453A`)
- **Rounded Cards & Subtle Separators**: iOS-native styling for a clean, premium feel.

---

## Integration Guidelines for Future Development

This modular architecture separates concerns so developers can connect backend integration layers without refactoring UI components:
- **Data Models**: `GameItem` and `AppItem` conform to `Codable` and `Identifiable`, allowing seamless JSON decoding from remote configuration servers.
- **State Management**: SwiftUI `@State` and `@Binding` propagate user interactions instantly across dashboard views and modal sheets.
- **Settings Binding**: `GameSettings` struct captures all ESP and Aim parameters, ready to be serialized and passed to underlying injection engines.
