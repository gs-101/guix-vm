{ lib, pkgs, ... }:

{
  
  home = {
    username = "guix-home-manager-container";
    homeDirectory = "/home/guix-home-manager-container";
    stateVersion = "24.11";
  };

  programs = with pkgs; {
    home-manager.enable = true;
  };

  targets.genericLinux.enable = true;
}
