{ config, pkgs, lib, fetchFromGitHub, buildGoModule, ... }:


{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vlad";
  home.homeDirectory = "/Users/vlad";

  nixpkgs.overlays = [ (self: super: {
    krewfile = super.callPackage ./kubernetes/krewfile.nix {};
    kubectl-crossplane = super.callPackage ./kubernetes/kubectl-crossplane.nix {};
  }) ];

  imports = [
    (import ./kubernetes/krewfile-hm.nix { config=config; lib=lib; pkgs=pkgs; })
  ];

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
    "$HOME/.cargo/bin"
    "$HOME/.krew/bin"
  ];

  home.packages = [
    pkgs.kubectl-crossplane
    pkgs.krew
    pkgs.krewfile
    pkgs.civo
    pkgs.gettext
    pkgs.kubernetes-helm
    pkgs.kubectl
    pkgs.kind
    pkgs.upbound
    pkgs.gh
    pkgs.vim
    pkgs.tig
    pkgs.httpie
    pkgs.gnupg
    pkgs.git
    pkgs.go
    pkgs.cue
    pkgs.python3Full
    pkgs.python310Packages.pip
    pkgs.yq
    pkgs.jq
    pkgs.rustup
    pkgs.natscli
    pkgs.google-cloud-sdk
    pkgs.awscli2
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        maxConnRetry = 5;
      };
    };
  };

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

  home.file.".cargo/bin/rust" = {
    executable = true;
    text = ''
      #!/bin/bash

      name=$(basename $1 .rs)
      path=./.bin/$name
      mkdir -p .bin
      rustc --out-dir .bin $@ && chmod +x $path && $path
      rm ./$path
    '';
  };

  programs.krewfile = {
    enable = true;
    plugins = [
      "gke-credentials"
      "whoami"
      "krew"
    ];
  };

}
