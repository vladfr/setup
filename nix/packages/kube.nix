{ config, pkgs, ... }:

{
    config = {
        home.packages = with pkgs; [
            k9s
            kind
            kubectl
            kustomize
            kubectx
            kubernetes-helm
            krew
            cmctl
            pinniped
            ytt
            kapp
            argocd
            fluxcd

            # sbom
            cosign
            syft
            grype

            # dev
            kubebuilder
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