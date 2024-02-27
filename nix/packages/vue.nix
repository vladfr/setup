{ config, ... }:
let
    pkgs = import <unstable> { config = { allowUnfree = true; }; };
in
{
    config = {
        home.packages = with pkgs; [
            supabase-cli
        ];
    };
}