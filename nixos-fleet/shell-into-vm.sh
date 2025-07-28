#!/usr/bin/env bash
set -e
# Build and run the codespace-01 NixOS VM, then open an interactive shell

# Ensure netcat is installed (Ubuntu: netcat-openbsd)
if ! command -v nc >/dev/null 2>&1; then
  echo "netcat (nc) not found. Installing..."
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y netcat-openbsd
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y nmap-ncat
  else
    echo "No supported package manager found. Please install netcat manually."
    exit 1
  fi
fi

# Build the VM with experimental features enabled
nix --extra-experimental-features nix-command --extra-experimental-features flakes build .#nixosConfigurations.codespace-01.config.system.build.vm 

VM_RUN="result/bin/run-codespace-01-vm"
if [ ! -x "$VM_RUN" ]; then
  echo "VM runner $VM_RUN not found or not executable. Build may have failed."
  exit 1
fi

# Start the VM in the background
echo "Starting the NixOS VM..."
$VM_RUN &
VM_PID=$!

# Ensure the VM is killed on exit
cleanup() {
  if kill -0 $VM_PID 2>/dev/null; then
    kill $VM_PID
  fi
}
trap cleanup EXIT

# Wait for the VM to boot and SSH to be available
VM_SSH_PORT=2222
ATTEMPTS=30
for i in $(seq 1 $ATTEMPTS); do
  if nc -z localhost $VM_SSH_PORT; then
    break
  fi
  sleep 1
done

if ! nc -z localhost $VM_SSH_PORT; then
  echo "VM did not start or SSH not available on port $VM_SSH_PORT."
  exit 1
fi

# SSH into the VM as the codespace user
ssh -p $VM_SSH_PORT -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null codespace@localhost
