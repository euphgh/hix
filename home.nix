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
                        fd
                                nil
                                bat
                                mill
                                bear
                                xclip
                                trashy
                                neofetch
                                verilator
                                llvmPackages_15.libclang
                                jdk17_headless
                ];
        };
        programs.bash = {
                enable = true;
                profileExtra = ''
                        export EDITOR=nvim
                        export HTTP_PROXY=http://127.0.0.1:7891
                        export HTTPS_PROXY=http://127.0.0.1:7891
                        export ALL_PROXY=http://127.0.0.1:7891
                        '';
                sessionVariables = {
                        EDITOR = "nvim";
                        HTTP_PROXY = "http://127.0.0.1:7891";
                        HTTPS_PROXY = "http://127.0.0.1:7891";
                        ALL_PROXY = "http://127.0.0.1:7891";
                };
                shellAliases = {
                        ls="ls --color";
                        ll="ls -alF ";
                        la="ls -A ";
                        l="ls -CF ";
                        mj="make -j \$(nproc)";
                        rm="echo you must use del and delclean instead of rm else use \\rm";
                        tp="trash put";
                        ip="ip --color=auto";
                        ".."="cd ..";
                        "..."="cd ../..";
                        "...."="cd ../../..";
                        grep="grep --color=auto";
                        cat="bat --paging=never";
                };
        };
        imports = (import ./nvim);
}
