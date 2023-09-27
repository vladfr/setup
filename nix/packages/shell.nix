{ config, pkgs, ... }:

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
            yq
            jq
            tree
            curl
            colordiff
            cocoapods
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
            initExtraFirst =
            ''
                # Nix - keep here for MacOS upgrades
                if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
                source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
                fi
                # End Nix
            '';
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

        home.file.".gnupg/gpg-agent.conf".text = ''
            grab
            default-cache-ttl 60480000
            max-cache-ttl 60480000
            pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
        '';

        programs.gpg = {
            enable = true;
        };
    };
}
