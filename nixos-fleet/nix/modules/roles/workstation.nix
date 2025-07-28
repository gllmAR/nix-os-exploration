{ pkgs, ... }:
{
  imports = [
    ../base/system.nix
    ../base/users.nix
    ../networking/ssh.nix
    ../audio/pipewire.nix
    ../graphics/wayland-labwc.nix
    ../apps/basic.nix
    ../apps/multimedia-dev.nix
  ];

  users.users.ga = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "input" ];
  };

  services.greetd.settings.default_session.user = "ga";
}