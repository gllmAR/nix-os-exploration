{ lib, pkgs, ... }:
{
  imports = [
    ../../nix/hardware/intel-n100-n150.nix
    ../../nix/modules/roles/signage.nix
    ../../nix/modules/graphics/accel/intel-vaapi.nix
    ./hardware-configuration.nix
    ./project.nix
  ];

  networking.hostName = "n150-01";
}