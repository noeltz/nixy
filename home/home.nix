{ pkgs, ... }:
let variable = import ../variables.nix;
in {

  imports = [ ./themes ./system ./scripts ./apps ];

  home = {
    username = variable.username;
    homeDirectory = variable.homeDirectory;

    packages = with pkgs; [
      swappy
      imv
      discord
      obsidian
      btop
      xfce.thunar
      bitwarden
      vlc

      # Dev
      go
      cargo
      nodejs
      python3
      jq

      # Utils
      sops # Secrets
      age # Secrets
      fd
      bc
      gcc
      blueman
      zip
      unzip
      xdg_utils
      wget
      curl
      neovide
      wf-recorder

      # Just cool
      peaclock
      cbonsai
      pipes
      cmatrix

      # Backup
      vscode
      firefox
      tor-browser
    ];

    stateVersion = variable.stateVersion;
  };
  programs.home-manager.enable = true;
}
