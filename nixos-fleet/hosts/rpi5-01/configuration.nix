{ lib, pkgs, ... }:
{
  imports = [
    ../../nix/hardware/rpi5.nix
    ../../nix/modules/roles/signage.nix
    ../../nix/modules/graphics/accel/rpi5-video.nix
    ./hardware-configuration.nix
    ./project.nix
  ];

  networking.hostName = "rpi5-01";
}