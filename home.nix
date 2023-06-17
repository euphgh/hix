{ pkgs, ... }:

{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.home-manager.enable = true;
  home = {
    packages = with pkgs; [
      fd
      btop
      ripgrep
      nil
      nixpkgs-fmt
      gnumake
      bat
      mill
      bear
      stdenv.cc
      xclip
      trashy
      verilator
      llvmPackages_15.libclang
      jdk17_headless
      ammonite
    ];
    stateVersion = "23.05";
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls --color";
      ll = "ls -alF ";
      la = "ls -A ";
      l = "ls -CF ";
      mj = "make -j \$(nproc)";
      tp = "trash put";
      ip = "ip --color=auto";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      grep = "grep --color=auto";
      cat = "bat --paging=never";
    };
    logoutExtra =''jps | sed -E "/.*Jps.*/d" | sed -E "s/([0-9]+).*/kill -9 \1/" | source /dev/stdin'';
  };
  imports = (import ./nvim);
}
