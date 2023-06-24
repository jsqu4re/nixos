{ config, pkgs, ... }:

{
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
      "192.168.1.220:8443:8443"
      "192.168.1.220:3478:3478/udp"
      "192.168.1.220:10001:10001/udp"
      "192.168.1.220:8080:8080"
      "192.168.1.220:1900:1900/udp"
      "192.168.1.220:8843:8843"
      "192.168.1.220:8880:8880"
      "192.168.1.220:6789:6789"
      "192.168.1.220:5514:5514/udp"
    ];
  };
}

