{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.intel-media-driver ];
  };
  environment.variables.VAAPI_DRIVER_NAME = "iHD";
}