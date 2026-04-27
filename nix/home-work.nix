{ config, pkgs, lib, ... }:


{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vfratila";
  home.homeDirectory = "/Users/vfratila";

  imports = [
    ./packages/shell/shell.nix
    ./packages/shell/azure.nix
    ./packages/lang.nix
    ./packages/kube.nix
    ./packages/cloud-cli.nix
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
  home.stateVersion = "25.11";
  # home.enableNixpkgsReleaseCheck = false;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  manual.html.enable = false;

  # Disable the built-in Home Manager check for App Management permissions
  targets.darwin = {
    copyApps.enable = false;
    copyApps.enableChecks = false;
  };

}
