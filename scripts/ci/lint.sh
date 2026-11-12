#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."

shellcheck scripts/*.sh scripts/ci/*.sh skills/*/scripts/*.sh
actionlint
nixfmt --check flake.nix nix/*.nix
