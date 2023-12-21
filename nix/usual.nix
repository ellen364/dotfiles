{ config, pkgs, ... }:

{
  imports = [./shared.nix];
 
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "__CHANGE_ME__";
  home.homeDirectory = "__CHANGE_ME__";
}

