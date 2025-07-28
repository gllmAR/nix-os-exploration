#!/usr/bin/env bash
set -e

# Interactive NixOS Fleet Installer

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

function choose_host() {
  echo "Available hosts:"
  hosts=()
  i=1
  for d in "$REPO_DIR"/hosts/*; do
    if [ -d "$d" ]; then
      host=$(basename "$d")
      hosts+=("$host")
      echo "  $i) $host"
      ((i++))
    fi
  done
  if [ -n "$HOST_CHOICE" ]; then
    idx="$HOST_CHOICE"
    echo "(Injected) Select a host to deploy [1-${#hosts[@]}]: $idx"
  else
    echo -n "Select a host to deploy [1-${#hosts[@]}]: "
    read idx
  fi
  if [[ "$idx" =~ ^[0-9]+$ ]] && (( idx >= 1 && idx <= ${#hosts[@]} )); then
    echo "Selected host: ${hosts[$((idx-1))]}"
    CHOSEN_HOST="${hosts[$((idx-1))]}"
  else
    echo "Invalid selection. Exiting."
    exit 1
  fi
}

function choose_action() {
  echo "What do you want to do?"
  echo "  1) Build NixOS system for this host"
  echo "  2) Deploy to remote machine (via nixos-rebuild)"
  echo "  3) Exit"
  if [ -n "$ACTION_CHOICE" ]; then
    action="$ACTION_CHOICE"
    echo "(Injected) Select an action [1-3]: $action"
  else
    read -p "Select an action [1-3]: " action
  fi
  NIX_CMD="nix --extra-experimental-features nix-command --extra-experimental-features flakes"
  NIXOS_REBUILD_CMD="nixos-rebuild --extra-experimental-features nix-command --extra-experimental-features flakes"
  case $action in
    1)
      echo "Building system for $CHOSEN_HOST..."
      $NIX_CMD build ".#nixosConfigurations.$CHOSEN_HOST.config.system.build.toplevel"
      ;;
    2)
      read -p "Enter remote user@host: " remote
      echo "Deploying to $remote..."
      $NIXOS_REBUILD_CMD switch --flake ".#$CHOSEN_HOST" --target-host "$remote"
      ;;
    3)
      echo "Exiting."
      exit 0
      ;;
    *)
      echo "Invalid action. Exiting."
      exit 1
      ;;
  esac
}

# Main
choose_host
choose_action
