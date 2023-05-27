{ pkgs, ... }:

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
                                verilator
                                llvmPackages_15.libclang
                                jdk17_headless
                ];
        };
        programs.bash = {
                enable = true;
                shellAliases = {
                        ls="ls --color";
                        ll="ls -alF ";
                        la="ls -A ";
                        l="ls -CF ";
                        mj="make -j \$(nproc)";
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
