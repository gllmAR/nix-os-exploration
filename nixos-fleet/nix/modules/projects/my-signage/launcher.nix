{ pkgs, lib, ... }:
let
  exec = "${pkgs.obs-studio}/bin/obs --profile signage --portable";
in
{
  systemd.user.services.signage-launcher = {
    description = "Signage Project Launcher";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = exec;
      Restart = "on-failure";
      Environment = "XDG_SESSION_TYPE=wayland";
    };
  };
}