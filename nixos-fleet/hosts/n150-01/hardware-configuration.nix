{ config, lib, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.efiSupport = true;

  networking.useDHCP = true;

  hardware.pci.enable = true;

  # Configure the CPU
  hardware.cpu.intel.enable = true;

  # Set up the memory
  boot.kernelParams = [ "intel_iommu=on" ];

  # Enable the necessary devices
  hardware.enableAllFirmware = true;

  # Set up the graphics card
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "intel" ];

  # Set up the audio
  hardware.pulseaudio.enable = false;
  services.pipewire.enable = true;

  # Set up the network interfaces
  networking.interfaces.enp0s3.useDHCP = true;
}