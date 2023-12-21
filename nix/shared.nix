{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # Some ideas: https://github.com/ibraheemdev/modern-unix
  # TODO: add `bat` or `most` as a better pager? (change pager settings too) think might get things like colored man pages
  home.packages = [
    pkgs.duf               # better df
    pkgs.entr              # run arbitrary commands when file changes
    pkgs.fd                # better find
    pkgs.htop              # better top
    pkgs.httpie            # http client
    pkgs.jq                # filter and transform json
    pkgs.just              # command runner
    pkgs.lunarvim          # neovim with ide config
    pkgs.meld              # visual diff tool
    pkgs.nerdfonts         # common dev fonts
    pkgs.nix-prefetch-git  # find sha for fetchFromGitHub
    pkgs.ripgrep           # faster grep
    pkgs.thefuck           # correct previous console command
    pkgs.tldr              # man pages focusing on examples
    pkgs.tmux              # terminal multiplexer
    pkgs.tree              # indented directory listing
    pkgs.zoxide            # better cd, remembers commonly used directories
    pkgs.zsh
    pkgs.zsh-powerlevel10k

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ellen/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # https://nix-community.github.io/home-manager/options.xhtml#opt-fonts.fontconfig.enable
  fonts.fontconfig.enable = true;

  # Useful for seeing what programs are available before searching the full options page
  # https://github.com/nix-community/home-manager/tree/master/modules/programs

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.fzf.enable
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.git.enable
  programs.git = {
    enable = true;
    # better diff'ing
    delta.enable = true;
    delta.options = {
      lineNumbers = true;
      # sideBySide = true;
    };
    extraConfig = {
      core = {
        editor = "lvim";
      };
      diff = {
        colorMoved = true;
      };
      merge = {
        conflictstyle = "diff3";
        # better tool for resolving merge conflicts
        tool = "meld";
      };
      push = {
        autoSetupRemote = true;
      };
      rerere = {
        # remember how merges were resolved
        enable = true;
        autoupdate = true;
      };
    };
  };

  # https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix
  programs.zsh = {
    enable = true;
    history = {
      size = 100000;
      extended = true;               # save timestamps
      ignoreDups = true;
      ignoreAllDups = false;
      expireDuplicatesFirst = true;
      share = true;                  # share between zsh sessions
    };
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    shellAliases = {
      ll = "ls -lha";
      ".." = "cd ..";
    };
    initExtra = ''
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
    fi

    # To customise prompt, run `p10k configure` or edit ~/.p10k.zsh
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    eval $(thefuck --alias)
    '';

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
}

