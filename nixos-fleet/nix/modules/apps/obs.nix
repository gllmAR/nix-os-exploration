{ pkgs, ... }:
let
  plugins = with pkgs; [
    obs-wlrobs          # Wayland screen capture
    obs-vkcapture       # Vulkan capture
    obs-move-transition
    obs-shaderfilter
    obs-v4l2sink
    obs-gstreamer
    # obs-distro-av     # NDI (if you need it; ensure deps)
  ];
in
{
  environment.systemPackages = [ pkgs.obs-studio ] ++ plugins;

  # Optional: seed profiles/scenes from /etc/obs or /opt/obs-profile/*
  environment.etc."obs/profiles/signage/basic.ini".text = ''
    [General]
    Name=signage
  '';
}