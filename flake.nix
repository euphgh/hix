{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      # 强制 NUR 和该 flake 使用相同版本的 nixpkgs
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      # 强制 home-manager 和该 flake 使用相同版本的 nixpkgs
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nur, ... }:
    let
      system = "x86_64-linux";
    in
    {
      homeConfigurations."hgh" = home-manager.lib.homeManagerConfiguration {
        modules = [
          nur.nixosModules.nur
          ./home.nix
        ];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      };
      nixosConfigurations."nyx" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nur.nixosModules.nur
          ./configuration.nix
        ];
      };
    };
}
