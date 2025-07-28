{
  pkgs ? import <nixpkgs> {},
  lib ? import <nixpkgs/lib> {}
}:

let
  obsPlugins = with pkgs; [
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
  self: super: {
    # Overlay for OBS plugins
    obs-studio = super.obs-studio.override {
      # Add the plugins to the OBS Studio package
      plugins = obsPlugins;
    };
  };
}