{ config, ... }:

let
    pkgs = import <unstable> { config = { allowUnfree = true; }; };
in
{
    config = {
        home.packages = with pkgs; [
            kind
            kubectl
            etcd
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
            wireshark-cli
            termshark
            kubeshark
            oras # oci registry as storage - cli tool for oci images; for wasm
            buildah

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