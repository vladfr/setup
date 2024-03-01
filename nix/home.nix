{ config, pkgs, lib, ... }:


{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vlad";
  home.homeDirectory = "/Users/vlad";

  imports = [
    ./packages/shell/shell.nix
    ./packages/lang.nix
    ./packages/kube.nix
    ./packages/cloud-cli.nix
    ./packages/vue.nix
    ./packages/db.nix
    ./packages/local.nix
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.file.".config/nix/nix.conf".text = ''
    keep-derivations = true
    keep-outputs = true
    experimental-features = nix-command flakes
  '';

}
