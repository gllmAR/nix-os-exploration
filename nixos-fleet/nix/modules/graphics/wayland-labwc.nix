{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.labwc}/bin/labwc";
        user = "signage";  # or "ga" for workstation
      };
    };
  };

  programs.waybar.enable = true;
  environment.systemPackages = with pkgs; [ labwc waybar wlogout seatd ];
  services.xserver.enable = false;  # pure Wayland
}