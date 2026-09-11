#!/usr/bin/env bash
# Create or rotate the persistent T3 Code bootstrap token for cobec-spark.
set -euo pipefail

T3_HOME="${T3_HOME:-$HOME/.t3}"
SECRETS_DIR="$T3_HOME/dev/secrets"
TOKEN_FILE="$SECRETS_DIR/persistent-bootstrap.token"
PUBLIC_HOST="${T3CODE_PUBLIC_HOST:-cobec-spark}"
WEB_PORT="${T3CODE_WEB_PORT:-5733}"

mkdir -p "$SECRETS_DIR"
chmod 700 "$SECRETS_DIR"

if [[ -f "$TOKEN_FILE" && "${1:-}" != "--rotate" ]]; then
  TOKEN="$(tr -d '[:space:]' < "$TOKEN_FILE")"
  echo "Reusing existing persistent bootstrap token at $TOKEN_FILE"
else
  TOKEN="$(
    openssl rand -base64 24 | tr -dc '23456789ABCDEFGHJKLMNPQRSTUVWXYZ' | head -c 12
  )"
  umask 077
  printf '%s\n' "$TOKEN" > "$TOKEN_FILE"
  chmod 600 "$TOKEN_FILE"
  echo "Wrote new persistent bootstrap token to $TOKEN_FILE"
fi

PAIR_URL="http://${PUBLIC_HOST}:${WEB_PORT}/#token=${TOKEN}"

echo ""
echo "Bookmark this URL in each browser you use (one click to pair):"
echo "  $PAIR_URL"
echo ""
echo "Restart the T3 Code service so the server loads the token:"
echo "  systemctl --user restart t3code-spark-dev.service"
echo ""
echo "Security: anyone who can reach this host and knows the token gets owner access."
echo "Rotate with: $0 --rotate"
