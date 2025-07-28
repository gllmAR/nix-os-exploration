{ config, lib, ... }:
{
  imports = [ 
    ../../nix/hardware/rpi5.nix 
  ];

  networking.wireless.enable = true;
  networking.wireless.networks = {
    "your-ssid" = {
      psk = "your-password";
    };
  };

  hardware.enableAllFirmware = true;
}