#!/usr/bin/env bash
# bundle-artifact.sh - produce shareable builds of a Flutter artifact.
#
# Usage:
#   bash scripts/bundle-artifact.sh <project-dir> [apk|web|all]
#
# Outputs land in <project-dir>/dist/:
#   web  -> dist/<name>-web.zip       (static site, host anywhere)
#   apk  -> dist/<name>-release.apk   (Android install file)
#
# Notes:
#   * apk requires the Android SDK (ANDROID_HOME or Android Studio install).
#   * the APK is signed with the debug key - fine for trials, NOT for store
#     publishing. Set up a real upload key before releasing publicly.
#   * 'all' builds every target whose toolchain is available.
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: bash scripts/bundle-artifact.sh <project-dir> [apk|web|all]" >&2
  exit 2
fi

PROJECT_DIR="$1"
MODE="${2:-all}"
cd "$PROJECT_DIR"

NAME="$(grep '^name:' pubspec.yaml | awk '{print $2}')"
DIST="dist"
mkdir -p "$DIST"

have_android_sdk() {
  [[ -n "${ANDROID_HOME:-}" || -n "${ANDROID_SDK_ROOT:-}" ]] || flutter config --list 2>/dev/null | grep -q 'android-sdk'
}

build_web() {
  echo ">> flutter build web --release"
  flutter build web --release
  ( cd build && rm -f "../$DIST/$NAME-web.zip" && zip -qr "../$DIST/$NAME-web.zip" web )
  echo "web bundle: $DIST/$NAME-web.zip (deploy the build/web directory to any static host)"
}

build_apk() {
  if ! have_android_sdk; then
    echo "skip: Android SDK not found; cannot build apk (web build still available)" >&2
    return 0
  fi
  echo ">> flutter build apk --release"
  flutter build apk --release
  cp build/app/outputs/flutter-apk/app-release.apk "$DIST/$NAME-release.apk"
  echo "apk: $DIST/$NAME-release.apk (debug-key signed; set up an upload key before publishing)"
}

case "$MODE" in
  web) build_web ;;
  apk) build_apk ;;
  all) build_web; build_apk ;;
  *) echo "error: unknown mode '$MODE' (apk|web|all)" >&2; exit 2 ;;
esac

echo
echo "Artifacts in $PROJECT_DIR/$DIST:"
ls -la "$DIST"
