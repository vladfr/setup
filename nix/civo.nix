# get civo from nixpkgs-unstable
{ pkgs, config, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> {};
in
{
  nixpkgs.overlays = [
    (self: super: {
      civo = pkgsUnstable.civo;
    })
  ];
}