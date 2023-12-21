# Nix README

## Get started

1. Multi-user installation of Nix (not NixOS) from [nixos.org](https://nixos.org/download)
2. Standalone installation of home manager (master version because using standalone Nix) [install docs](https://nix-community.github.io/home-manager/#sec-install-standalone)
3. Clone this dotfiles repo
4. In ~/.config/home-manager, create symlinks to `shared.nix` and `usual.nix`, naming the latter to `home.nix`
5. Replace the username and home directory in `usual.nix`  (TODO: grab these from a local file?)
6. Use new config: `home-manager switch`
7. If needed, set login shell to zsh: `chsh -s $(which zsh)`, logout and back in

## Useful notes

Quote bash substitution using `''`, e.g. `''${HOME}` in a something like pagkages.zsh.extraInit


> Since ${ and '' have special meaning in indented strings, you need a way to quote them. $ can be escaped by prefixing it with '' (that is, two single quotes), i.e., ''$. '' can be escaped by prefixing it with ', i.e., '''. $ removes any special meaning from the following $. Linefeed, carriage-return and tab characters can be written as ''\n, ''\r, ''\t, and ''\ escapes any other character.
> https://nixos.org/manual/nix/stable/language/values.html
