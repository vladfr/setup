{ config, pkgs, ... }:

{
    imports = [
        ./rust.nix
    ];

    config = {
        home.packages = with pkgs; [
            cue
            go
            ko
            python3Full
            python310Packages.pip
        ];
    };

}