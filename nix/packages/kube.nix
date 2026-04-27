{ config, ... }:

let
    pkgs = import <unstable> { config = { allowUnfree = true; }; };
in
{
    config = {
        home.packages = with pkgs; [
            kind
            minikube
            ctlptl
            kubectl
            etcd
            kustomize
            kubectx
            kubernetes-helm
            krew
            cmctl
           # pinniped
            ytt
            kapp
            argocd
            fluxcd
            oras # oci registry as storage - cli tool for oci images; for wasm
            # buildah - not working
            # kubelogin # moved to local
            kubelogin-oidc

            # sbom
            cosign
            syft
            grype

            # dev
            kubebuilder
            operator-sdk
            tilt
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
