{ config, pkgs, ...}:

{
    config = {
        home.packages = with pkgs; [
            rustup
        ];

        home.file.".cargo/bin/rust" = {
            executable = true;
            text = ''
            #!/bin/bash

            name=$(basename $1 .rs)
            path=./.bin/$name
            mkdir -p .bin
            rustc --out-dir .bin $@ && chmod +x $path && $path
            rm ./$path
            '';
        };
    };
}