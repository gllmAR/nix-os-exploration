{ pkgs, ... }:
{
  # Test for the signage configuration using a VM
  imports = [
    (import ../../nix/modules/roles/signage.nix { inherit pkgs; })
    (import ../../nix/modules/graphics/wayland-labwc.nix { inherit pkgs; })
    (import ../../nix/modules/apps/obs.nix { inherit pkgs; })
  ];

  # Define the VM test
  nixosTests = {
    signageTest = {
      testScript = ''
        # Start the Wayland session and check for OBS
        systemctl start wayvnc
        sleep 5
        if ! pgrep -x "obs" > /dev/null; then
          echo "OBS is not running!"
          exit 1
        fi
        echo "OBS is running successfully."
      '';
    };
  };
}