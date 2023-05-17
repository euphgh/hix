{ pkgs, lib, config, ... }:
{
  programs.vscode = {
    enable = lib.mkDefault true;
    userSettings = (builtins.fromJSON (builtins.readFile ./settings.json));
    extensions = with pkgs.vscode-extensions; [
      arcticicestudio.nord-visual-studio-code
      scalameta.metals
      redhat.java
    ];
  };
}
