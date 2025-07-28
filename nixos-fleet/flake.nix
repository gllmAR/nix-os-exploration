{
  description = "Fleet: RPi5 + Intel N150/N4010 (Wayland/labwc, OBS, dev tools)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";     # one track for consistency
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # optional: cachix, sops-nix, nixos-hardware, etc.
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    lib = nixpkgs.lib;
    forAll = f: lib.genAttrs systems (system:
      f (import nixpkgs { inherit system; config.allowUnfree = true; })
    );
  in
  {
    # Dev shell & formatter
    devShells = forAll (pkgs: {
      default = pkgs.mkShell { packages = with pkgs; [ git tmux alejandra statix deadnix ]; };
    });
    formatter = forAll (pkgs: pkgs.alejandra);

    nixosConfigurations = {
      # Raspberry Pi 5 example host
      rpi5-01 = let pkgs = import nixpkgs { system = "aarch64-linux"; config.allowUnfree = true; }; in nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit self pkgs; };
        modules = [
          ./hosts/rpi5-01/configuration.nix
          home-manager.nixosModules.home-manager
          { home-manager.useGlobalPkgs = true; home-manager.useUserPackages = true; }
        ];
      };

      # Intel N150/N100-class example host
      n150-01 = let pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; }; in nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self pkgs; };
        modules = [
          ./hosts/n150-01/configuration.nix
          home-manager.nixosModules.home-manager
          { home-manager.useGlobalPkgs = true; home-manager.useUserPackages = true; }
        ];
      };

      # Intel N4010-class example host
      n4010-01 = let pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; }; in nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self pkgs; };
        modules = [
          ./hosts/n4010-01/configuration.nix
          home-manager.nixosModules.home-manager
          { home-manager.useGlobalPkgs = true; home-manager.useUserPackages = true; }
        ];
      };
      # Codespace example host
      codespace-01 = let pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; }; in nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self pkgs; };
        modules = [
          ./hosts/codespace-01/configuration.nix
          home-manager.nixosModules.home-manager
          { home-manager.useGlobalPkgs = true; home-manager.useUserPackages = true; }
        ];
      };
    };

    # Add NixOS VM tests to flake checks
    checks = forAll (pkgs: {
      signage-vm = import ./tests/signage-vm.nix { inherit pkgs; };
    });
  };
}