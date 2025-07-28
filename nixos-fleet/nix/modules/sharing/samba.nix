{ config, pkgs, lib, ... }:
{
  fileSystems."/mnt/share" = {
    device = "/dev/disk/by-uuid/PUT-UUID-HERE";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" "x-systemd.idle-timeout=60s" ];
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      "global" = {
        workgroup = "WORKGROUP";
        "map to guest" = "Bad User";
        "server min protocol" = "SMB2";
      };
      "homes" = { browseable = "no"; "read only" = "no"; };
      "share" = {
        path = "/mnt/share";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };
}