{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Basic tools
    tmux
    git
    htop
    ripgrep
    fd
    jq

    # Additional utilities can be added here
  ];

  # User-specific configurations can be added here
  # For example, setting up shell configurations or other dotfiles
}