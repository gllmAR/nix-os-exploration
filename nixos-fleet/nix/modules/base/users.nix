{ pkgs, ... }:
{
  users.users.ga = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "input" ];
    shell = pkgs.bashInteractive;
    initialPassword = "changeme"; # switch to ssh keys asap; or use sops-nix
  };
  security.sudo.wheelNeedsPassword = false;
}