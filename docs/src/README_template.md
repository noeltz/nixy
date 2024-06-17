
# Nixy

**Nixy** is a NixOS configuration with home-manager, secrets and custom theming all in one place.
It's a simple way to manage your system configuration and dotfiles.

## Table of Content

{md_table_of_content}

## Gallery

![nixy1](docs/src/nixy/1.png)
![nixy2](docs/src/nixy/2.png)
![nixy3](docs/src/nixy/3.png)

## Architecture

- 🏠 `home` are the dotfiles and configuration files for the user
- 💻 `hosts` are the system configuration files
  - `laptop` is mine
  - `guest` is a template that you can copy and modify for your own system
  - `themes` contains all the themes available (see [docs/THEMES.md])
  - `shared` are some nix files that you can import (nvidia, prime, fonts, ...)
- 🤫 `secrets` are the secrets files encrypted with sops

## Installation

```sh
git clone https://github.com/anotherhadi/nixy ~/.config/nixos
```

- Change the username in the flake.nix file
- import the guest configuration instead of the `hosts/laptop` one
- import your hardware-configuration.nix into the `hosts/guest` folder

```sh
sudo nixos-rebuild switch --flake ~/.config/nixos#nixy
```