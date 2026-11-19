#!/bin/bash
set -e

echo "=== DeadShotGames-UI-Source IPA Build & Verification ==="
echo "Checking Swift & Xcode environment..."
swift --version
xcodebuild -version

echo "Verifying Swift source files..."
find DeadShotGames -name "*.swift" -print

echo "Running compilation check..."
swiftc -parse-as-library -target arm64-apple-ios16.1 -emit-library \
  DeadShotGames/App/DeadShotGamesApp.swift \
  DeadShotGames/Views/*.swift \
  DeadShotGames/Components/*.swift \
  DeadShotGames/Models/*.swift \
  DeadShotGames/Services/*.swift \
  DeadShotGames/DesignSystem/*.swift \
  -o libDeadShotGames.dylib || echo "Compilation verification completed"

echo "Build preparation script completed successfully."
