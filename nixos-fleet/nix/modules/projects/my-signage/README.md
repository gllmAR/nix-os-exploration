# My Signage Project

This README provides documentation for the My Signage project, which is part of the NixOS fleet configuration. The project is designed to set up a signage system using NixOS, leveraging various modules for system configuration, remote access, and application management.

## Purpose

The My Signage project aims to create a reliable and efficient signage solution that can run on various hardware platforms, including Raspberry Pi 5 and Intel N150/N4010-class devices. It utilizes Wayland for display management and OBS Studio for streaming content.

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/nixos-fleet.git
   cd nixos-fleet
   ```

2. **Configure Your Host**
   - Navigate to the `hosts` directory and edit the configuration files for your specific hardware (e.g., `rpi5-01`, `n150-01`, `n4010-01`).
   - Ensure that the necessary modules are imported in the `configuration.nix` file.

3. **Build the Configuration**
   - Use the following command to build the NixOS configuration for your host:
   ```bash
   sudo nixos-rebuild switch --flake .#<your-host-name>
   ```

4. **Launch the Signage Application**
   - The signage application is managed by a systemd user service defined in `launcher.nix`. It will automatically start upon user login.

## Usage

- The signage system will automatically launch the configured applications upon startup.
- You can manage the systemd services using standard commands:
  ```bash
  systemctl --user start project-launcher
  systemctl --user stop project-launcher
  ```

## Project Structure

- **Modules**: The project utilizes various Nix modules for configuration, including base system settings, user management, networking, and application installations.
- **Hardware Configurations**: Specific configurations for different hardware platforms are located in the `nix/hardware` directory.
- **Secrets**: Sensitive information should be stored in the `secrets` directory, using encryption to ensure security.

## Testing

- The project includes tests located in the `tests` directory to validate the signage configuration using a virtual machine.

## Contributions

Contributions to the My Signage project are welcome. Please submit a pull request or open an issue for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.