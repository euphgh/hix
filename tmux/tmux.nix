{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    escapeTime = 0;
    secureSocket = false;
    keyMode = "vi";
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
source ${./config/mytmux.conf}
'';
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      nord
    ];
  };
}
