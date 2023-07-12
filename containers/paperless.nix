{ config, pkgs, ... }:

{
  containers.paperless = {
    autoStart = true;
    macvlans = [ "enp1s0" ];

    config = {
      networking.interfaces.mv-enp1s0 = {
        ipv4.addresses = [ { address = "192.168.1.141"; prefixLength = 24;  }];
      };
      networking.defaultGateway.address = "192.168.1.1";
      networking.firewall.enable = false;
      system.stateVersion = "23.05";

      services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
      };

      services.nginx.virtualHosts."paperless.haus" = {
        serverName = "paperless.haus";
        addSSL = false;
        enableACME = false;
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:28981";
          };
        };
      };
      security.acme = {
        acceptTerms = true;
        defaults.email = "johannes.jeising+nginx@gmail.com";
      };     

      services.paperless = {
        enable = true;
        extraConfig = {
          PAPERLESS_OCR_LANGUAGE = "deu+eng";
          # PAPERLESS_AUTO_LOGIN_USERNAME = "admin";
        }; 
      };
    };
  };
}
