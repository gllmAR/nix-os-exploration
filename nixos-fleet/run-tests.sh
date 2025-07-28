#!/usr/bin/env bash
set -euo pipefail

# Ensure Nix is available
if ! command -v nix &>/dev/null; then
  echo "Nix is not installed. Please install Nix first."
  exit 1
fi

# Enable flakes and nix-command features
export NIX_CONFIG="experimental-features = nix-command flakes"

# Move to the nixos-fleet directory if not already there
cd "$(dirname "$0")"


# Clean: remove flake.lock if it exists
if [ -f flake.lock ]; then
  echo "Removing existing flake.lock for a clean test run..."
  rm flake.lock
fi

echo "Running NixOS tests (flake checks)..."
nix flake check --show-trace --extra-experimental-features nix-command --extra-experimental-features flakes

echo "All tests completed."
