{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vlad";
  home.homeDirectory = "/Users/vlad";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionPath = [
    "$HOME/go/bin"
    "/usr/local/bin/"
  ];

  home.packages = [ pkgs.gettext pkgs.kubernetes-helm pkgs.gh pkgs.vim pkgs.tig pkgs.httpie pkgs.gnupg pkgs.git pkgs.kind ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    shellAliases = {
        gst = "tig status";
        ga = "git add";
        gc = "git commit -v";
        gp = "git pull";
        gl = "git push";
        dps = "docker ps";
        dpsa = "docker ps --all";
        drm = "docker rm -fv";
        dco = "docker-compose";
        k = "kubectl";
    };
    initExtra = 
    ''
        source $HOME/.bash_secrets
    '';
    oh-my-zsh = {
        enable = true;
        theme = "rixius";

        plugins = [
          "command-not-found"
          "git"
          "history"
          "sudo"
          "kubectl"
          "kubectx"
        ];
    };
  };

  home.file.".tigrc".text = ''
    bind status C !git commit --signoff
  '';

  home.file.".config/nix/nix.conf".text = ''
    keep-derivations = true
    keep-outputs = true
  '';
}
