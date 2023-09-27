{ config, pkgs, ... }:

{
    imports = [
        ./rust.nix
    ];

    config = {
        home.packages = with pkgs; [
            cue
            go
            goreman
            ko
            python3Full
            python310Packages.pip
            nodejs_20
            yarn
        ];
    };

}