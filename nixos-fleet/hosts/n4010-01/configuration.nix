{ 
  imports = [
    ../../nix/hardware/intel-n4010.nix
    ../../nix/modules/roles/signage.nix
    ../../nix/modules/graphics/accel/intel-i965.nix
    ./hardware-configuration.nix
    ./project.nix
  ];

  networking.hostName = "n4010-01";
}