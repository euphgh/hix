{
  description = "Home Manager configuration of hgh";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        inherit pkgs;
        "hgh" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./user/hgh.nix ];
        };
        "lt" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [  ./user/lt.nix ];
        };
        "xyf" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./user/xyf.nix ];
        };
    };
  };
}