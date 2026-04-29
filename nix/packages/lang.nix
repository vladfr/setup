{ config, unstable, ... }:

{
    imports = [
        ./rust.nix
    ];

    config = {
        home.packages = with unstable; [
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
            virtualenv
        ];
    };

}
