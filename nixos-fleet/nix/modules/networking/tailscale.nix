{ pkgs, ... }:
{
  services.tailscale = {
    enable = true;
    authKey = "your-auth-key-here";  # Replace with your Tailscale auth key
    # Optional: configure additional settings as needed
    # hostname = "your-desired-hostname"; 
  };
}