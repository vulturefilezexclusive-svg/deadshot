# DeadShotGames

Native SwiftUI iOS interface project targeting iOS 16.1 and later.

## Screens
- Games dashboard with language selector, overflow menu, game rows, status indicators, play and information actions.
- Apps screen with search, category filters, and selectable app rows.
- Per-game settings with ESP display preferences, aim configuration controls, and a save action.
- Dark visual theme sized for modern iPhone screens.

## Project layout
- `DeadShotGames/App`: application entry point.
- `DeadShotGames/Views`: dashboard, apps, game settings, and information screens.
- `DeadShotGames/Components`: reusable rows, search, status, and settings sections.
- `DeadShotGames/Models`: game and app data models.
- `DeadShotGames/DesignSystem`: colors, spacing, and card styling.
- `project.yml`: XcodeGen project definition.
- `.github/workflows/build.yml`: macOS GitHub Actions build.

## Build with GitHub Actions
Push to `main` or manually run **iOS Build** from the Actions tab. The workflow generates an Xcode project, compiles the app for iOS, packages the app bundle into an unsigned IPA archive, and uploads the build log and artifacts.

## Signing note
The workflow creates an **unsigned IPA archive**. Installing on a physical iPhone requires signing with a valid Apple Development/Distribution certificate and a matching provisioning profile. No signing credentials are stored in this repository.

## Scope
This repository contains the application interface and local configuration state. It does not include process inspection, memory access, code injection, sandbox escape, anti-detection, or game-manipulation implementations.
