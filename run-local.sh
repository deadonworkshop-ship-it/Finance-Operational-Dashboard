#!/usr/bin/env bash
set -euo pipefail

PORT="${1:-4173}"
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

get_local_ip() {
  if command -v ipconfig >/dev/null 2>&1; then
    local ip
    ip="$(ipconfig getifaddr en0 2>/dev/null || true)"
    if [[ -n "${ip}" ]]; then
      echo "${ip}"
      return
    fi
  fi

  if command -v hostname >/dev/null 2>&1; then
    local ip
    ip="$(hostname -I 2>/dev/null | awk '{print $1}')"
    if [[ -n "${ip}" ]]; then
      echo "${ip}"
      return
    fi
  fi

  echo ""
}

LOCAL_IP="$(get_local_ip)"

echo "Starting Finance Operational Dashboard..."
echo "Project folder: ${ROOT_DIR}"
echo ""
echo "Open on this computer:"
echo "  http://localhost:${PORT}"

if [[ -n "${LOCAL_IP}" ]]; then
  echo "Open on your iPhone (same Wi-Fi):"
  echo "  http://${LOCAL_IP}:${PORT}"
else
  echo "Could not auto-detect your local IP for phone testing."
  echo "You can still open http://localhost:${PORT} on this computer."
fi

echo ""
echo "Press Ctrl+C to stop the server."

echo ""
python3 -m http.server "${PORT}" --directory "${ROOT_DIR}"
