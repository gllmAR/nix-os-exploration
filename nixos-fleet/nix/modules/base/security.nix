{ pkgs, ... }:
{
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 5900 6080 ]; # Allow SSH and VNC ports

  security.pam.services.sshd = {
    # Use PAM for SSH login
    enable = true;
    settings = {
      "auth required pam_unix.so" = {};
      "auth required pam_tally2.so" = { deny = 5; onerr = fail; };
      "account required pam_unix.so" = {};
    };
  };

  security.sudo.wheelNeedsPassword = false; # Allow wheel group to execute sudo without password
}