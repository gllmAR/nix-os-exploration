{ pkgs, ... }:
{
  # Enable Intel-specific features
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = [ pkgs.intel-media-driver ];

  # Set the VA-API driver for Intel GPUs
  environment.variables.VAAPI_DRIVER_NAME = "iHD";

  # Additional configurations can be added here as needed
}