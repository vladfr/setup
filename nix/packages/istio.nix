{ config, pkgs, ... }:

let
    istiopkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/6e3a86f2f73a466656a401302d3ece26fba401d9.tar.gz";
    }) {};
in
{
    config = {
        home.packages = [ istiopkgs.istioctl ];
    };
}