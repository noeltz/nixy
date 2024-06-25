{ pkgs, config, ... }: {

  imports = [
    ../hosts/laptop/variables.nix # CHANGEME, replace with your host

    # Programs
    ./programs/btop
    ./programs/cava
    ./programs/kitty
    ./programs/nextcloud
    ./programs/nvim
    ./programs/qutebrowser
    ./programs/spicetify
    ./programs/zathura
    ./programs/shell
    ./programs/git

    # Scripts
    ./scripts # All scripts

    # System (Desktop environment like stuff)
    ./system/dunst
    ./system/gtk
    ./system/hyprland
    ./system/waybar
    ./system/wlogout
    ./system/wofi
    ./system/mime
    ./system/udiskie

    ./system/sops/laptop.nix # You should probably remove this line
  ];

  home = {
    inherit (config.var) username;
    inherit (config.var) homeDirectory;

    packages = with pkgs; [
      swappy
      imv
      discord
      obsidian
      xfce.thunar
      bitwarden
      vlc
      nextcloud-client
      tailscale

      # Dev
      go
      cargo
      nodejs
      python3
      jq
      git-ignore
      nurl
      prefetch-npm-deps
      figlet

      # Utils
      fd
      bc
      gcc
      blueman
      zip
      unzip
      xdg_utils
      wget
      curl
      wf-recorder
      glow
      nwg-displays
      wireguard-tools
      bitwarden-cli
      optipng
      pfetch
      usbutils

      # Just cool
      peaclock
      cbonsai
      pipes
      cmatrix

      # Backup
      vscode
      tor-browser
      firefox
      neovide
    ];

    # Import wallpapers into $HOME/wallpapers
    file."wallpapers" = {
      recursive = true;
      source = ./wallpapers;
    };

    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

}
