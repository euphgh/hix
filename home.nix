{ config, pkgs, lib, ... }:

{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.home-manager.enable = true;

  home = {
    username = "hgh";
    homeDirectory = "/home/hgh";
    stateVersion = "22.11";
    packages = with pkgs; [
      mill
      xclip
      neofetch
      trashy
      bear
      bat
      jdk17_headless
    ];
  };

  imports = (import ./nvim) ++ (import ./zsh);

  home.sessionVariables = {
    EDITOR = "nvim";
    HTTP_PROXY = "http://127.0.0.1:7890";
    HTTPS_PROXY = "http://127.0.0.1:7890";
    ALL_PROXY = "http://127.0.0.1:7890";
  };
}
