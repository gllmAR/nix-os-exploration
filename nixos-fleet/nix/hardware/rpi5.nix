{ pkgs, ... }:
{
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ mesa ffmpeg mpv ];
  };

  # Ensure that the necessary kernel modules are loaded
  boot.kernelModules = [ "v4l2loopback" "v4l2" ];

  # Set up any additional configurations specific to Raspberry Pi 5
}