{ pkgs, lib,config, ... }:
{
  services.nginx.enable = true;
  services.nginx.virtualHosts."jelly.zu.haus" = {
    serverName = "zu.haus";
    addSSL = false;
    enableACME = false;
    locations = {
      "/" = {
        proxyPass = "http://127.0.0.1:8096";
      };
      "/home" = {
        proxyPass = "http://192.168.1.221:8123";
      };
      "/unifi" = {
        proxyPass = "http://192.168.1.220:8080";
      };
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "johannes.jeising+nginx@gmail.com";
  };
}
