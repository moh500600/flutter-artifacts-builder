#!/usr/bin/env bash
# test-artifact.sh - quality gates for a Flutter artifact.
#
# Usage:
#   bash scripts/test-artifact.sh <project-dir> [--update-goldens]
#
# Runs, in order:
#   1. flutter analyze          (static analysis, strict lints)
#   2. flutter test             (unit + widget tests)
#   3. golden screenshots       (rendered to <project-dir>/test/goldens/*.png)
#
# Pass --update-goldens to (re)generate the reference screenshots, e.g. after
# an intentional visual change. Inspect the PNGs before treating visual work
# as done.
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: bash scripts/test-artifact.sh <project-dir> [--update-goldens]" >&2
  exit 2
fi

PROJECT_DIR="$1"
GOLDEN_FLAG="${2:-}"

cd "$PROJECT_DIR"

echo ">> flutter analyze"
flutter analyze

echo ">> flutter test"
if [[ "$GOLDEN_FLAG" == "--update-goldens" ]]; then
  flutter test --update-goldens
else
  flutter test
fi

echo
echo "Golden screenshots: $PROJECT_DIR/test/goldens/"
ls -1 test/goldens/*.png 2>/dev/null || echo "(none found - run with --update-goldens)"
