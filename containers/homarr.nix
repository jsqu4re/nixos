{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers."homarr" = {
    autoStart = true;
    image = "ghcr.io/ajnart/homarr:latest";
    environment = {
      # "PUID" = "1000";
      # "PGID" = "100";
      # "TZ" = "Etc/UTZ";
      # "MEM_LIMIT" = "1024";
      # "MEM_STARTUP" = "1024";
    };
    volumes = [
      "/home/jsqu4re/workspace/homarr/configs:/app/data/configs"
      "/home/jsqu4re/workspace/homarr/icons:/app/public/icons"
    ];
    extraOptions = [
      "--network=host"
    ];
    ports = [
      "192.168.1.41:7575:7575"
      ];
  };
}

