{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.vaapiIntel ];
  };
  environment.variables.VAAPI_DRIVER_NAME = "i965";
}