{ config, pkgs, ... }:

{
  containers.uptime = {
    autoStart = true;
    macvlans = [ "enp1s0" ];

    config = {
      networking.interfaces.mv-enp1s0 = {
        ipv4.addresses = [ { address = "192.168.1.143"; prefixLength = 24;  }];
      };
      networking.defaultGateway.address = "192.168.1.1";
      networking.firewall.enable = false;
      system.stateVersion = "23.05";

      services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
      };

      services.nginx.virtualHosts."uptime.haus" = {
        serverName = "uptime.haus";
        addSSL = false;
        enableACME = false;
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:3001";
            extraConfig = ''
               proxy_http_version 1.1;
               proxy_set_header   Upgrade $http_upgrade;
               proxy_set_header   Connection "upgrade";
               proxy_set_header   Host $host;
            '';
          };
        };
      };
      security.acme = {
        acceptTerms = true;
        defaults.email = "johannes.jeising+nginx@gmail.com";
      };     

      services.uptime-kuma = {
        enable = true;
      };
    };
  };
}
