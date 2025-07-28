{ config, lib, ... }:
{
  imports = [ ../../nix/hardware/intel-n100-n150.nix ];
  # No hardware-specific options for Codespace VM
}
