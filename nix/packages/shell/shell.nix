{ config, pkgs, lib, unstable, ... }:

{
    config = {

        home.packages = with pkgs; [
            gettext
            vim
            tig
            httpie
            git
            gnupg
            pinentry_mac
            gh
            pre-commit
            yamllint
            yamlfix
            yq-go
            gnused
            tree
            curl
            colordiff
            cocoapods
            fzf
            fzf-zsh
            fzf-make
            devbox
            uv
            turbo
            pprof
        ];

        home.sessionPath = [
            "$HOME/go/bin"
            "/usr/local/bin/"
            "$HOME/.cargo/bin"
            "$HOME/.krew/bin"
            "$HOME/.local/bin"
        ];

        programs.zsh = {
            enable = true;
            enableCompletion = true;
            syntaxHighlighting = {
                enable = true;
            };
	    autosuggestion = {
		enable = true;
	    };
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
            initContent = lib.mkMerge [
              (lib.mkBefore ''
                # Set up oh-my-zsh custom directory
                ZSH_CUSTOM=~/.oh-my-zsh/custom

                # Nix - keep here for MacOS upgrades
                if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
                source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
                fi
                # End Nix
              '')
              ''
                source $HOME/.bash_secrets
                source $HOME/.env

                export GOPRIVATE=github.com/upsidr,go.upsider.dev,github.com/Adobe-Apis,git.corp.adobe.com,gitlab.com/kaloracloud

                eval "$(/opt/homebrew/bin/brew shellenv)"
              ''
            ];
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

        home.file.".config/nix/nix.conf".text = ''
            keep-derivations = true
            keep-outputs = true
            experimental-features = nix-command flakes
        '';

        home.file.".oh-my-zsh/custom/themes/rixius.zsh-theme".source = ./zsh_custom/rixius.zsh-theme;

        home.file.".tigrc".text = ''
            bind status C !git commit --signoff
        '';

        home.file.".gnupg/gpg-agent.conf".text = ''
            grab
            default-cache-ttl 60480000
            max-cache-ttl 60480000
            pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
        '';

	home.file.".ssh/config".source = ./ssh/config;

        home.file.".gitconfig-upsidr".text = ''
            [user]
                name = Vlad Fratila
                email = vlad.fratila@up-sider.com
                signingkey = 169BC5940861DD5D
        '';

        home.file.".gitconfig-adobe".text = ''
            [user]
                name = Vlad Fratila
                email = vfratila@adobe.com
                signingkey = 428200459C8718D7
        '';

        home.file.".gitconfig-adobeghec".text = ''
            [user]
                name = Vlad Fratila
                email = vfratila@adobe.com
                signingkey = 428200459C8718D7
            [core]
                sshCommand = ssh -i ~/.ssh/ghec_ed25519
        '';

        home.file.".gitconfig-kalora".text = ''
            [user]
                name = Vlad Fratila
                email = vlad@kaloracloud.eu
                signingkey = 2A0509AD43225F97
        '';

        home.file.".gitconfig".source = ./git/gitconfig;
        home.file.".gitignore".source = ./git/gitignore;

        programs.gpg = {
            enable = true;
        };

        programs.direnv = {
            enable = true;
            enableZshIntegration = true;
            nix-direnv.enable = true;
            package = unstable.direnv;
        };
    };
}
