#!/bin/bash
set -euo pipefail

echo "Generating Xcode project..."
xcodegen generate --spec project.yml

echo "Building unsigned iOS app..."
mkdir -p build
xcodebuild \
  -project DeadShotGames.xcodeproj \
  -scheme DeadShotGames \
  -configuration Release \
  -sdk iphoneos \
  -destination 'generic/platform=iOS' \
  -derivedDataPath build/DerivedData \
  CODE_SIGNING_ALLOWED=NO \
  build

APP_PATH="build/DerivedData/Build/Products/Release-iphoneos/DeadShotGames.app"
test -d "$APP_PATH"

mkdir -p build/ipa/Payload
rm -rf build/ipa/Payload/DeadShotGames.app
cp -R "$APP_PATH" build/ipa/Payload/
ditto -c -k --sequesterRsrc --keepParent build/ipa/Payload build/DeadShotGames-unsigned.ipa

echo "Created build/DeadShotGames-unsigned.ipa"
echo "This archive is unsigned and requires signing with an Apple Distribution certificate and provisioning profile before installation."
