{ config, ... }:

{
  systemd.services.ClashPre = {
    enable = true;
    unitConfig = {
      Description = "Clash daemon, A rule-based proxy in Go.";
      After = "network-online.target";
    };
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      ExecStart = "${config.nur.repos.linyinfeng.clash-premium}/bin/clash-premium -d /home/hgh/.local/etc/clash";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
