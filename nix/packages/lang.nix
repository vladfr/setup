{ config, ... }:

let

  pkgs = import <unstable> {};

in
{
    imports = [
        ./rust.nix
    ];

    config = {
        home.packages = with pkgs; [
            cue
            go
            tinygo
            goreman
            ko
            python3Full
            python310Packages.pip
            nodejs_20
            yarn
        ];
    };

}