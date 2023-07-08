{ pkgs, lib, ... }:
{
  programs.vscode = {
    enable = lib.mkDefault true;
    # userSettings = (builtins.fromJSON (builtins.readFile ./settings.json));
    extensions = with pkgs.vscode-extensions; [
      arcticicestudio.nord-visual-studio-code
      asvetliakov.vscode-neovim
      llvm-vs-code-extensions.vscode-clangd
      jnoortheen.nix-ide
      ms-vscode.hexeditor
      mhutchie.git-graph
      mkhl.direnv
      # scalameta.metals
      # scala-lang.scala
    ];
  };
}
