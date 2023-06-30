{ config, pkgs, ... }:

{

    imports = [
        ../kubernetes/krewfile-hm.nix
    ];

    config = {

        nixpkgs.overlays = [ (self: super: {
            krewfile = super.callPackage ../kubernetes/krewfile.nix {};
            kubectl-crossplane = super.callPackage ../kubernetes/kubectl-crossplane.nix {};
            #teller = super.callPackage ../tools/teller.nix {};
        }) ];


        home.packages = with pkgs; [
            krewfile
            kubectl-crossplane
            #teller
        ];

        programs.krewfile = {
            enable = true;
            plugins = [
            "whoami"
            "krew"
            ];
        };
    };

}