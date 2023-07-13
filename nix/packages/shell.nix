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
            gh
            yq
            jq
            tree
            curl
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

    };
}