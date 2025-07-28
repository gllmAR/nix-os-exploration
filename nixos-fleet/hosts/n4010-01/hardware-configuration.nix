{ config, lib, ... }:
{
  boot.loader.grub.device = "/dev/sda"; # Adjust based on your actual device
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable hardware-specific settings for Intel N4010
  hardware.enableAllFirmware = true;

  # Configure CPU settings
  hardware.cpu.intel.enable = true;

  # Set up video acceleration
  hardware.videoDrivers = [ "intel" ];

  # Configure network interfaces
  networking.interfaces.enp0s3.useDHCP = true; # Adjust interface name as needed

  # Set up additional hardware configurations if necessary
  # e.g., USB devices, peripherals, etc.
}