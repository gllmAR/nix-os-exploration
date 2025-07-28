{ pkgs, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;  # you can disable after first setup
      ChallengeResponseAuthentication = false;
      UsePAM = true;
      X11Forwarding = false;
      AllowAgentForwarding = false;
      AllowTcpForwarding = false;
      MaxAuthTries = 3;
      MaxSessions = 10;
      ClientAliveInterval = 300;
      ClientAliveCountMax = 2;
    };
  };
}