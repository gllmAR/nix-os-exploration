{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pcmanfm
    alacritty
    firefox
  ];
}