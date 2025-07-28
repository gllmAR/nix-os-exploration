{ pkgs, ... }:
{
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  services.timesyncd.enable = true;

  nix.settings = { experimental-features = [ "nix-command" "flakes" ]; };
  environment.systemPackages = with pkgs; [ tmux git htop ripgrep fd jq ];

  networking.firewall.enable = true;
}