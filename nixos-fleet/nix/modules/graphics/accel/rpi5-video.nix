{ pkgs, ... }:
{
  hardware.opengl = {
    enable = true;
    extraPackages = [ pkgs.mesa ];
  };

  environment.systemPackages = with pkgs; [
    ffmpeg
    mpv
  ];
}