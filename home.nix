{ config, pkgs, ... }:

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
      (pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-full;
      })
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
  };
  xdg.dataFile = {
    BloopKill = {
      executable= true;
      text = ''
        #!/bin/sh

        # Find all Java processes.
        jps_output=$(jps)

        # Check if a process named "Main" exists.
        if echo "$jps_output" | grep -q "Main"; then
            echo "Process named 'Main' already exists, nothing to do."
        else
            # If "Main" process does not exist, check if a process named "Server" exists.
            if echo "$jps_output" | grep -q "Server"; then
                # If "Server" process exists, kill it.
                server_pid=$(echo "$jps_output" | grep "Server" | cut -d " " -f 1)
                echo "Process named 'Server' found with PID $server_pid. Killing it..."
                kill "$server_pid"
            else
                # If neither "Main" nor "Server" process exists, do nothing.
                echo "No 'Main' or 'Server' process found, nothing to do."
            fi
        fi
      '';
    };
  };
  systemd.user = {
    timers."BloopKillTimer" = {
      Unit = {
        Description = "Timer of BloopKill Services";
      };
      Timer = {
        OnUnitActiveSec = "10m";
        Unit = "BloopKill.service";
      };
      Install.WantedBy = [ "timers.target" ];
    };
    services.BloopKill = {
      Unit = { Description = "Kill bloop when metals not run"; };
      Service = {
        Type = "oneshot";
        ExecStart = "/bin/sh ${config.xdg.dataHome}/BloopKill";
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
  imports = (import ./nvim);
}
