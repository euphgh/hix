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
      cachix
      chromium
      qq
      qbittorrent
      vlc
      fd
      btop
      ripgrep
      jdk17_headless
      mill
      stdenv.cc
      gnumake
      sshfs

      xclip
      flameshot
      neofetch
      trashy
      patchelf
      file
      gtkwave

      # compress
      p7zip
      rar
      zip
      unzip
      musescore
      nodePackages_latest.musescore-downloader

      bear
      bat
      (pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-full;
      })
    ];
  };
  systemd.user = {
    timers."BloopKillTimer" = {
      Unit = {
        Description = "Timer of BloopKill Services";
      };
      Timer = {
        OnUnitActiveSec = "1s";
        OnActiveSec = "1s";
        Unit = "BllopKill.service";
      };
      Install.WantedBy = [ "timers.target" ];
    };
    services = {
      mpris-proxy = {
        Unit.Description = "Mpris proxy";
        Unit.After = [ "network.target" "sound.target" ];
        Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
        Install.WantedBy = [ "default.target" ];
      };
    };
  };
  imports = (import ./nvim) ++ (import ./tmux) ++ (import ./zsh) ++ [
    ./vscode/default.nix
    ./alacritty/default.nix
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

