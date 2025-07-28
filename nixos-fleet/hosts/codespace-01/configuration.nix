{ config, pkgs, ... }:

# Set the codespace user password here. Override with:
#   nixos-rebuild ... --argstr codespacePassword mypass
# or via flake inputs if desired.
let
  codespacePassword = "test";
in
{
  imports = [ ../../nix/hardware/intel-n100-n150.nix ];

  networking.hostName = "codespace-01";
  time.timeZone = "UTC";

  # Minimal system for Codespace VM (no GUI)
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
    htop
    bash
  ];


  users.users.codespace = {
    isNormalUser = true;
    home = "/home/codespace";
    extraGroups = [ "wheel" ];
    initialPassword = codespacePassword;
    openssh.authorizedKeys.keys = [];
  };



  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = true;
  services.openssh.extraConfig = ''
    PermitEmptyPasswords yes
  '';

  # Minimal root filesystem and boot loader for VM/test
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  boot.loader.grub.devices = [ "/dev/vda" ];

  system.stateVersion = "24.11";
}
