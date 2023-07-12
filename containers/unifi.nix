{ config, pkgs, ... }:

{
 # containers.unifi = {
 #   autoStart = true;
 #   macvlans = [ "enp1s0" ];

 #   config = {
 #     networking.interfaces.mv-enp1s0 = {
 #       ipv4.addresses = [ { address = "192.168.1.220"; prefixLength = 24; } ];
 #     };
 #     networking.defaultGateway.address = "192.168.1.1";
 #     networking.firewall.enable = false;
 #     system.stateVersion = "23.05";

 #     services.nginx = {
 #       enable = true;
 #       recommendedProxySettings = true;
 #       recommendedTlsSettings = true;
 #     };

 #     services.nginx.virtualHosts."unifi.haus" = {
 #       serverName = "unifi.haus";
 #       addSSL = false;
 #       enableACME = false;
 #       locations = {
 #         "/" = {
 #           proxyPass = "http://192.168.1.41";
 #         };
 #       };
 #     };
 #   };
 # };
  # unifi controller
  virtualisation.oci-containers.containers."unifi" = {
    autoStart = true;
    image = "ghcr.io/linuxserver/unifi-controller:latest";
    environment = {
      "PUID" = "1000";
      "PGID" = "100";
      "TZ" = "Etc/UTZ";
      "MEM_LIMIT" = "1024";
      "MEM_STARTUP" = "1024";
    };
    volumes = [
      "/home/jsqu4re/workspace/unifi/unifi:/config"
    ];
    extraOptions = [
      "--network=host"
    ];
    ports = [
      "8443:8443"
      "3478:3478/udp"
      "10001:10001/udp"
      "8080:8080"
      "1900:1900/udp"
      "8843:8843"
      "8880:8880"
      "6789:6789"
      "5514:5514/udp"
    ];
  };
}

