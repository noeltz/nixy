{ config, ... }: {
  imports = [
    # ../../nixos/nvidia.nix # CHANGEME: Uncomment this line if you have an Nvidia GPU
    # ../../nixos/prime.nix # CHANGEME: Uncomment this line if you have an Nvidia GPU

    ../../nixos/audio.nix
    ../../nixos/auto-upgrade.nix
    ../../nixos/bluetooth.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/network-manager.nix
    ../../nixos/nix.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/timezone.nix
    ../../nixos/tuigreet.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/xdg-portal.nix
    ../../nixos/variables-config.nix
    ../../nixos/docker.nix
    # ../../nixos/pia.nix

    # Choose your theme here
    ../../themes/stylix/pinky.nix

    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "24.05";
}
