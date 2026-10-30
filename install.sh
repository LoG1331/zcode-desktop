#!/usr/bin/env bash
# Cài zcode-desktop: link script vào PATH rồi tải ZCode chính thức về máy.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${ZCODE_BIN_DIR:-$HOME/.local/bin}"

chmod +x "$REPO_DIR/bin/zcode-install" "$REPO_DIR/bin/zcode-remote"
mkdir -p "$BIN_DIR"

for tool in zcode-install zcode-remote; do
  ln -sfn "$REPO_DIR/bin/$tool" "$BIN_DIR/$tool"
  echo "linked: $BIN_DIR/$tool -> $REPO_DIR/bin/$tool"
done

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *)
    echo
    echo "Lưu ý: $BIN_DIR chưa có trong PATH. Thêm vào shell rc:"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    ;;
esac

echo
exec "$REPO_DIR/bin/zcode-install" "$@"
