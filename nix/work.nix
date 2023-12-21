{ config, pkgs, ... }:

{
  imports = [./shared.nix];
 
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "__CHANGE_ME__";
  home.homeDirectory = "__CHANGE_ME__";

  # Merges the home.packages defined here and in shared.nix
  home.packages = [
    pkgs.google-cloud-sdk
    pkgs.google-cloud-sql-proxy
  ];

  # Appends the string to the end of the initExtra that's in base.nix
  programs.zsh = {
    initExtra = ''
    # pyenv currently managed outside Nix
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    # nvm currently managed outside Nix
    export NVM_DIR="$([ -z "''${XDG_CONFIG_HOME-}" ] && printf %s "''${HOME}/.nvm" || printf %s "''${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    '';
  };
}

