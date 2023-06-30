{ config, pkgs, ... }:

{
    config = {
        home.packages = with pkgs; [
            k9s
            kind
            kubectl
            kubernetes-helm
            krew
            cmctl
            pinniped
            ytt
            kapp

            # sbom
            cosign
            syft
            grype
        ];

        programs.k9s = {
            enable = true;
            settings = {
                k9s = {
                    maxConnRetry = 5;
                };
            };
        };
    };

}