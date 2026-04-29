{
  description = "Home Manager configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "aarch64-darwin"; # use "x86_64-darwin" if on Intel Mac
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
    in {
      homeConfigurations."vlad.fratila" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit unstable; }; 
        modules = [ ./home-cresta.nix ];
      };
    };
}