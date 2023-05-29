{ config, pkgs, lib, ... }:

{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.home-manager.enable = true;
    nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  
  home = {
	username = "hgh";
    homeDirectory = "/home/hgh";
    stateVersion = "22.11";
    packages = with pkgs; [
      chromium
      qq
      fd
      ripgrep

      xclip
      flameshot
      neofetch
      trashy
      
      # compress
      p7zip
      rar

      bear
      bat
    ];
  };
  imports = (import ./nvim) ++ (import ./tmux) ++ (import ./zsh)  ++ [
    ./vscode/default.nix 
    ./alacritty/default.nix
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
