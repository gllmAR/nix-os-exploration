{ pkgs, ... }:
{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;   # Pulse shim
    jack.enable  = true;
  };
  hardware.pulseaudio.enable = false;
}