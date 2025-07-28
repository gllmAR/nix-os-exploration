{ pkgs, lib, config, ... }:
let
  wayvncArgs = "--address 0.0.0.0 --port 5900 --enable-auth none";
in
{
  # Wayland VNC as user service (starts with the session)
  systemd.user.services.wayvnc = {
    description = "WayVNC server (Wayland)";
    wantedBy    = [ "graphical-session.target" ];
    serviceConfig.ExecStart = "${pkgs.wayvnc}/bin/wayvnc ${wayvncArgs}";
    serviceConfig.Restart = "on-failure";
  };

  # noVNC via websockify, served on 6080
  systemd.services.novnc = {
    description = "noVNC (websockify) on :6080 → :5900";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.websockify}/bin/websockify 0.0.0.0:6080 localhost:5900 --web ${pkgs.novnc}/share/novnc";
      Restart = "on-failure";
    };
  };

  networking.firewall.allowedTCPPorts = [ 5900 6080 ];
}