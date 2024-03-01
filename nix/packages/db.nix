{ config, pkgs, ... }:

{
    config = {
        home.packages = with pkgs; [
            mysql80
        ];
    };
}
