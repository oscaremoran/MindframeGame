#!/bin/sh
# Builds Mindframe.app from ../index.html. Run it again after
# changing the game to pick up the new version. Nothing in the game folder is
# touched; the app gets its own copy of index.html.
set -e
cd "$(dirname "$0")"

GAME=../index.html
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
# the app is put together in a scratch folder and only swapped in once it is
# complete and signed, so there is never a half-built Mindframe.app to open
APP="$TMP/Mindframe.app"

mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"

# one binary that runs on both Intel and Apple Silicon Macs
swiftc -O -target x86_64-apple-macos11 src/main.swift -o "$TMP/x86_64"
swiftc -O -target arm64-apple-macos11  src/main.swift -o "$TMP/arm64"
lipo -create "$TMP/x86_64" "$TMP/arm64" -output "$APP/Contents/MacOS/Mindframe"

# the icon: the LANCER, drawn at every size macOS asks for, packed into .icns
swiftc -O src/icon.swift -o "$TMP/icon"
"$TMP/icon" "$TMP/AppIcon.iconset"
iconutil -c icns "$TMP/AppIcon.iconset" -o "$APP/Contents/Resources/AppIcon.icns"

cp "$GAME" "$APP/Contents/Resources/index.html"

cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key>                <string>Mindframe</string>
  <key>CFBundleDisplayName</key>         <string>Mindframe</string>
  <key>CFBundleIdentifier</key>          <string>com.oscarmoran.mindframe</string>
  <key>CFBundleExecutable</key>          <string>Mindframe</string>
  <key>CFBundleIconFile</key>            <string>AppIcon</string>
  <key>CFBundlePackageType</key>         <string>APPL</string>
  <key>CFBundleVersion</key>             <string>1</string>
  <key>CFBundleShortVersionString</key>  <string>1.0</string>
  <key>LSMinimumSystemVersion</key>      <string>11.0</string>
  <key>NSHighResolutionCapable</key>     <true/>
  <key>LSApplicationCategoryType</key>   <string>public.app-category.games</string>
</dict>
</plist>
PLIST

# ad-hoc signature: Apple Silicon will not run an unsigned binary at all
codesign --force --deep -s - "$APP"

# the zip the browser version's download link points at (ditto keeps the signature intact)
ditto -c -k --keepParent "$APP" "$TMP/Mindframe-mac.zip"

# swap both into place in one step each
rm -rf Mindframe.app.old
[ -d Mindframe.app ] && mv Mindframe.app Mindframe.app.old
mv "$APP" Mindframe.app
mv -f "$TMP/Mindframe-mac.zip" Mindframe-mac.zip
rm -rf Mindframe.app.old
echo "built $(pwd)/Mindframe.app and Mindframe-mac.zip"
