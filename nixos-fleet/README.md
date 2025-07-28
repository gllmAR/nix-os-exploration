# NixOS Fleet Configuration

This repository contains a modular NixOS configuration for managing a fleet of devices, including Raspberry Pi 5, Intel N150/N100-class, and Intel N4010-class machines. The configuration is designed to be reusable and extendable, allowing for easy management of different roles and applications across various hardware.

## Purpose

The primary goal of this project is to provide a consistent and reproducible environment for different devices using NixOS. It includes configurations for base system settings, user management, networking, remote access, file sharing, audio management, graphics, and application installations.

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/nixos-fleet.git
   cd nixos-fleet
   ```

2. **Build the Configuration**
   To build the configuration for a specific host, use the following command:
   ```bash
   nix build .#nixosConfigurations.<hostname>.config.system.build.toplevel
   ```
   Replace `<hostname>` with the desired host (e.g., `rpi5-01`, `n150-01`, or `n4010-01`).

3. **Switch to the Configuration**
   After building, switch to the configuration using:
   ```bash
   sudo nixos-rebuild switch --flake .#<hostname>
   ```

4. **Testing**
   To test the signage configuration in a VM, run:
   ```bash
   nix run nixpkgs#nixos-run-vm -- --flake .#rpi5-01
   ```

## Usage

- **Modules**: The configuration is organized into modules located in the `nix/modules` directory. Each module is responsible for a specific aspect of the system, such as base settings, networking, audio, and applications.
  
- **Roles**: Roles are defined in the `nix/modules/roles` directory, allowing for easy configuration of different types of machines (e.g., signage, workstation).

- **Projects**: Specific projects can be defined in the `nix/modules/projects` directory, with dedicated launchers for applications.

- **Secrets**: Sensitive information should be stored in the `secrets` directory, which is intended for encrypted secrets.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.