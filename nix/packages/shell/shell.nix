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
                # Set up oh-my-zsh custom directory
                ZSH_CUSTOM=~/.oh-my-zsh/custom

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

        home.file.".gitconfig-upsidr".text = ''
            [user]
                name = Vlad Fratila
                email = vlad.fratila@up-sider.com
                signingkey = 169BC5940861DD5D
        '';

        home.file.".gitconfig".source = ./git/gitconfig;
        home.file.".gitignore".source = ./git/gitignore;

        programs.gpg = {
            enable = true;
        };
    };
}
