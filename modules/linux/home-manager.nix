{ config, pkgs, lib, ... }:

let
  user = "michael";
  xdg_configHome  = "/home/${user}/.config";
  shared-programs = import ../shared/home-manager.nix { inherit config pkgs lib; };
  shared-files = import ../shared/files.nix { inherit config pkgs; };
in
{
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix {};
    stateVersion = "24.05";
    # activation.chezmoi = lib.hm.dag.entryAfter [ "installPackages" ] ''
    #   $DRY_RUN_CMD ${pkgs.chezmoi}/bin/chezmoi init --apply <your dotfiles>
    # '';
  };

  programs = shared-programs // { 
    home-manager.enable = true;
  };

}
