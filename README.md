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

## Installing
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

**Full version with secrets management**

```sh
mkdir -p nixos-config && cd nixos-config && nix flake --extra-experimental-features 'nix-command flakes' init -t github:michaelhaaf/nixos-config#starter-with-secrets
```

### Make [apps](https://github.com/dustinlyons/nixos-config/tree/main/apps) executable
```sh
find apps/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f \( -name apply -o -name build -o -name build-switch -o -name create-keys -o -name copy-keys -o -name check-keys \) -exec chmod +x {} \;
```

### Apply current user info
Run this Nix command to automatically replace stub values for system properties, username, full name, and email.

```sh
nix run .#apply
```

> [!NOTE]
> If you're using a git repository, only files in the working tree will be copied to the [Nix Store](https://zero-to-nix.com/concepts/nix-store).
>
> You must run `git add .` first.

### Decide what packages to install
You can search for packages on the [official NixOS website](https://search.nixos.org/packages).

**Review these files**

* [`modules/darwin/casks.nix`](https://github.com/dustinlyons/nixos-config/blob/main/modules/darwin/casks.nix)
* [`modules/darwin/packages.nix`](https://github.com/dustinlyons/nixos-config/blob/main/modules/darwin/packages.nix)
* [`modules/shared/packages.nix`](https://github.com/dustinlyons/nixos-config/blob/main/modules/shared/packages.nix)

### Review shell configuration
Add anything from your existing `~/.zshrc`, or just review the new configuration.

**Review these files**

* [`modules/darwin/home-manager`](https://github.com/dustinlyons/nixos-config/blob/main/modules/darwin/home-manager.nix)
* [`modules/shared/home-manager`](https://github.com/dustinlyons/nixos-config/blob/main/modules/shared/home-manager.nix)

### Setup secrets

#### Create a private Github repo to hold your secrets
In Github, create a private [`nix-secrets`](https://github.com/dustinlyons/nix-secrets-example) repository with at least one file (like a `README`). You'll enter this name during installation.

#### Install keys
Before generating your first build, these keys must exist in your `~/.ssh` directory. Don't worry, I provide a few commands to help you.

| Key Name            | Platform         | Description                           | 
|---------------------|------------------|-----------------------------------------------------------|
| id_ed25519          | macOS / NixOS    | Download secrets from Github. Used only during bootstrap. |
| id_ed25519_agenix   | macOS / NixOS    | Copied over, used to encrypt and decrypt secrets.         |

Run one of these commands:

##### Copy keys from USB drive
This command auto-detects a USB drive connected to the current system.
> Keys must be named `id_ed25519` and `id_ed25519_agenix`.
```sh
nix run .#copy-keys
```
##### Check existing keys
If you're rolling your own, just check they are installed correctly.
```sh
nix run .#check-keys
```

### Install configuration
Ensure the build works before deploying the configuration, run:
```sh
nix run .#build
```
> [!NOTE]
> If you're using a git repository, only files in the working tree will be copied to the [Nix Store](https://zero-to-nix.com/concepts/nix-store).
>
> You must run `git add .` first.

> [!WARNING]
> You may encounter `error: Unexpected files in /etc, aborting activation` if `nix-darwin` detects it will overwrite
> an existing `/etc/` file. The error will list the files like this:
> 
> ```
> The following files have unrecognized content and would be overwritten:
> 
>   /etc/nix/nix.conf
>   /etc/bashrc
> 
> Please check there is nothing critical in these files, rename them by adding .before-nix-darwin to the end, and then try again.
> ```
> Backup and move the files out of the way and/or edit your Nix configuration before continuing.

### Make changes
Finally, alter your system with this command:
```sh
nix run .#build-switch
```
> [!CAUTION]
> `~/.zshrc` will be replaced with the [`zsh` configuration](https://github.com/dustinlyons/nixos-config/blob/main/templates/starter/modules/shared/home-manager.nix#L8) from this repository. Make sure this is what you want.

## For linux containers
This configuration supports both `x86_64` and `aarch64` platforms.

### Setup secrets
If you are using the starter with secrets, there are a few additional steps.

#### Create a private Github repo to hold your secrets
In Github, create a private [`nix-secrets`](https://github.com/dustinlyons/nix-secrets-example) repository with at least one file (like a `README`). You'll enter this name during installation.

#### Install keys
Before generating your first build, these keys must exist in your `~/.ssh` directory. Don't worry, I provide a few commands to help you.

| Key Name            | Platform         | Description                           | 
|---------------------|------------------|-----------------------------------------------------------|
| id_ed25519          | macOS / NixOS    | Download secrets from Github. Used only during bootstrap. |
| id_ed25519_agenix   | macOS / NixOS    | Copied over, used to encrypt and decrypt secrets.         |

Run one of these commands:

##### Copy keys from USB drive
This command auto-detects a USB drive connected to the current system.
> Keys must be named `id_ed25519` and `id_ed25519_agenix`.
```sh
sudo nix run --extra-experimental-features 'nix-command flakes' github:michaelhaaf/nixos-config#copy-keys
```

## Making changes
With Nix, changes to your system are made by 
- editing your system configuration
- building the [system closure](https://zero-to-nix.com/concepts/closures)
- creating [a new generation](https://nixos.wiki/wiki/Terms_and_Definitions_in_Nix_Project#generation) based on this closure and switching to it

This is all wrapped up in the `build-switch` run command.

### Development workflow
So, in general, the workflow for managing your environment will look like
- make changes to the configuration
- run `nix run .#build-switch`
- watch Nix, `nix-darwin`, `home-manager`, etc do their thing
- go about your way and benefit from a declarative environment

### Trying packages
For quickly trying a package without installing it, I usually run
```sh
nix shell nixpkgs#hello
```

where `hello` is the package name from [nixpkgs](https://search.nixos.org/packages).
