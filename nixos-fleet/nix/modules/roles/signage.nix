{ pkgs, ... }:
{
  imports = [
    (import ../base/system.nix { inherit pkgs; })
    (import ../base/users.nix { inherit pkgs; })
    (import ../networking/ssh.nix { inherit pkgs; })
    (import ../audio/pipewire.nix { inherit pkgs; })
    (import ../graphics/wayland-labwc.nix { inherit pkgs; })
    (import ../apps/basic.nix { inherit pkgs; })
    (import ../apps/obs.nix { inherit pkgs; })
  ];

  users.users.signage = {
    isNormalUser = true;
    extraGroups = [ "video" "audio" "input" ];
  };
  
  services.greetd.settings.default_session.user = "signage";

  # auto-start project launcher (systemd --user), see projects/*/launcher.nix
}