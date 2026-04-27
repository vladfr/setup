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
            go
            bazel
            goreman
            ko
            readline
            xz
            sqlite
            openssl
            tcl
            tk
            nodejs_20
            yarn
        ];
    };

}
