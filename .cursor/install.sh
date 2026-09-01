#!/usr/bin/env bash
# Idempotent Cloud Agent setup for the game_sudoku Flutter app.
# Installs the pinned Flutter SDK (if missing), exposes it on PATH, and
# refreshes project dependencies. Safe to run repeatedly.
set -euo pipefail

FLUTTER_VERSION="3.47.0"
FLUTTER_DIR="$HOME/flutter"
ARCHIVE_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  echo "==> Installing Flutter ${FLUTTER_VERSION}"
  tmp="$(mktemp -d)"
  curl -fsSL -o "$tmp/flutter.tar.xz" "$ARCHIVE_URL"
  tar -xf "$tmp/flutter.tar.xz" -C "$HOME"
  rm -rf "$tmp"
else
  echo "==> Flutter already present at $FLUTTER_DIR"
fi

git config --global --add safe.directory "$FLUTTER_DIR"

if command -v sudo >/dev/null 2>&1; then
  sudo ln -sf "$FLUTTER_DIR/bin/flutter" /usr/local/bin/flutter
  sudo ln -sf "$FLUTTER_DIR/bin/dart" /usr/local/bin/dart
else
  ln -sf "$FLUTTER_DIR/bin/flutter" /usr/local/bin/flutter || true
  ln -sf "$FLUTTER_DIR/bin/dart" /usr/local/bin/dart || true
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

flutter config --enable-web --no-analytics >/dev/null
flutter precache --web

echo "==> Fetching project dependencies"
flutter pub get

flutter --version
