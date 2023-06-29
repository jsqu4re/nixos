{ pkgs, lib,config, ... }:
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  services.nginx.virtualHosts."nihil.haus" = {
    serverName = "nihil.haus";
    addSSL = false;
    enableACME = false;
    locations = {
      "/" = {
        proxyPass = "http://127.0.0.1:8096";
      };
      "/has/" = {
        proxyPass = "http://192.168.1.221:8123";
      };
      "/unifi/" = {
        proxyPass = "http://192.168.1.220:8443";
      };
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "johannes.jeising+nginx@gmail.com";
  };
}
