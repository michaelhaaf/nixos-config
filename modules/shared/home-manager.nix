{ config, pkgs, lib, ... }:

let name = "Michael Haaf";
    user = "michael";
    email = "michael.haaf@gmail.com"; in
{

  direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

}
