#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
PROJECT_DIR="${1:-$PWD}"
OUTPUT="${2:-teaser.mp4}"

cd "${PROJECT_DIR}"

if [[ ! -f "index.html" ]]; then
  echo "index.html not found in ${PROJECT_DIR}" >&2
  exit 1
fi

if [[ ! -f "cover.png" && -f "${DEMO_DIR}/assets/cover.png" ]]; then
  cp "${DEMO_DIR}/assets/cover.png" ./cover.png
fi

if [[ ! -f "cover.png" ]]; then
  echo "cover.png not found in ${PROJECT_DIR}. Copy it beside index.html before rendering." >&2
  exit 1
fi

if [[ -z "${HYPERFRAMES_BROWSER_PATH:-}" ]]; then
  HYPERFRAMES_BROWSER_PATH="$(command -v chromium-browser 2>/dev/null || command -v chromium 2>/dev/null || command -v google-chrome 2>/dev/null || command -v google-chrome-stable 2>/dev/null || true)"
  export HYPERFRAMES_BROWSER_PATH
fi

if [[ -z "${HYPERFRAMES_BROWSER_PATH}" ]]; then
  echo "No Chromium browser found. Run ${DEMO_DIR}/scripts/install-renderer-deps.sh or set HYPERFRAMES_BROWSER_PATH." >&2
  exit 1
fi

echo "Rendering ${PROJECT_DIR}/index.html to ${OUTPUT}"
echo "Using browser: ${HYPERFRAMES_BROWSER_PATH}"

npx --yes hyperframes render --output "${OUTPUT}"

echo "Rendered ${PROJECT_DIR}/${OUTPUT}"

