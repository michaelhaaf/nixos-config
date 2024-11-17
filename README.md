# Nix Config for macOS + linux containers

## Overview

This is a fork of [dustinlyons/nixos-config](https://github.com/dustinlyons/nixos-config).

This repository contains configuration for my development environment that runs Nix on macOS and linux containers (including WSL).

## Layout

```
.
├── apps         # nix commands used to bootstrap and build configuration
├── hosts        # host-specific configuration
├── modules      # macOS, nix-darwin, linux container, WSL, and shared configuration
├── overlays     # Drop an overlay file in this dir, and it runs. So far, mainly patches.
```

## For macOS (November 2024)
This configuration supports both Intel and Apple Silicon Macs.

### Install dependencies
```sh
xcode-select --install
```

### Install Nix
Thank you for the [installer](https://zero-to-nix.com/concepts/nix-installer), [Determinate Systems](https://determinate.systems/)!
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
After installation, open a new terminal session to make the `nix` executable available in your `$PATH`. You'll need this in the steps ahead.

> [!IMPORTANT]
>
> If using [the official installation instructions](https://nixos.org/download) instead, [`flakes`](https://nixos.wiki/wiki/Flakes) and [`nix-command`](https://nixos.wiki/wiki/Nix_command) aren't available by default.
>
> You'll need to enable them.
> 
> **Add this line to your `/etc/nix/nix.conf` file**
> ```
> experimental-features = nix-command flakes
> ```
> 
> **_OR_**
>
> **Specify experimental features when using `nix run` below**
> ```
> nix --extra-experimental-features 'nix-command flakes' run .#<command>
> ```

## For linux containers
This configuration supports both `x86_64` and `aarch64` platforms.

### Development workflow
So, in general, the workflow for managing your environment will look like
- make changes to the configuration
- run `nix run .#build-switch`
- watch Nix, `nix-darwin`, `home-manager`, etc do their thing
- go about your way and benefit from a declarative environment
