#!/usr/bin/env bash
# init-artifact.sh - scaffold a production-quality Flutter artifact project.
#
# Usage:
#   bash scripts/init-artifact.sh <project-name> [target-dir]
#
# <project-name> must be a valid Dart package name: lowercase_with_underscores.
# The script runs `flutter create`, then overlays the curated template
# (Material 3 theme, Tajawal font, provider state, navigation shell,
# sample screens, lints, widget + golden tests) and runs `flutter pub get`.
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: bash scripts/init-artifact.sh <project-name> [target-dir]" >&2
  exit 2
fi

NAME="$1"
TARGET_DIR="${2:-.}"

if ! [[ "$NAME" =~ ^[a-z][a-z0-9_]*$ ]]; then
  echo "error: '$NAME' is not a valid Dart package name (lowercase_with_underscores)" >&2
  exit 2
fi

if ! command -v flutter >/dev/null 2>&1; then
  echo "error: flutter not found in PATH. Install Flutter 3.50+ first." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(cd "$SCRIPT_DIR/../template" && pwd)"

echo ">> flutter create $NAME"
mkdir -p "$TARGET_DIR"
( cd "$TARGET_DIR" && flutter create --project-name "$NAME" --org com.example --platforms android,web "$NAME" )

PROJECT_DIR="$TARGET_DIR/$NAME"

echo ">> overlaying template"
cp "$TEMPLATE_DIR/pubspec.yaml" "$PROJECT_DIR/pubspec.yaml"
sed -i "s/__PROJECT_NAME__/$NAME/g" "$PROJECT_DIR/pubspec.yaml"
cp "$TEMPLATE_DIR/analysis_options.yaml" "$PROJECT_DIR/analysis_options.yaml"
rm -rf "$PROJECT_DIR/lib" "$PROJECT_DIR/test"
cp -r "$TEMPLATE_DIR/lib" "$PROJECT_DIR/lib"
cp -r "$TEMPLATE_DIR/test" "$PROJECT_DIR/test"
cp -r "$TEMPLATE_DIR/assets" "$PROJECT_DIR/assets"
grep -rl '__PROJECT_NAME__' "$PROJECT_DIR/test" | xargs sed -i "s/__PROJECT_NAME__/$NAME/g"

echo ">> flutter pub get"
( cd "$PROJECT_DIR" && flutter pub get )

cat <<DONE

Done. Project ready at $PROJECT_DIR

Next steps:
  cd $PROJECT_DIR
  flutter run -d chrome        # develop on web
  flutter run                  # develop on a connected device/emulator

Quality gates and shareable builds:
  bash $SCRIPT_DIR/test-artifact.sh $PROJECT_DIR      # analyze + tests + golden screenshots
  bash $SCRIPT_DIR/bundle-artifact.sh $PROJECT_DIR    # release build (apk and/or web)
DONE
