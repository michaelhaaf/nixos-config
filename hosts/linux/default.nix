{ config, inputs, lib, pkgs, agenix, ... }:

let user = "michael"; in
{
  imports = [
    ../../modules/shared
    agenix.nixosModules.default
  ];

  # Manages keys and such
  programs = {
    gnupg.agent.enable = true;
  };

  services = {
    # Enable CUPS to print documents
    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ]; # Brother printer driver
    };
    # My editor runs as a daemon
    emacs = {
      enable = true;
      package = pkgs.emacs-unstable;
    };
  };

  systemd.user.services.emacs = {
    serviceConfig.TimeoutStartSec = "7min";
  };

  fonts.packages = with pkgs; [
    dejavu_fonts
    emacs-all-the-icons-fonts
    feather-font # from overlay
    jetbrains-mono
    font-awesome
    noto-fonts
    noto-fonts-emoji
    fira
    fira-code
  ];

  environment.systemPackages = with pkgs; [
    agenix.packages."${pkgs.system}".default # "x86_64-linux"
    gitAndTools.gitFull
    linuxPackages.v4l2loopback
    v4l-utils
    inetutils
  ];

  system.stateVersion = "24.05"; # Don't change this

}
