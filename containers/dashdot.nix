{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers."dashdot" = {
    autoStart = true;
    image = "ghcr.io/mauricenino/dashdot:latest";
    environment = {
      # "PUID" = "1000";
      # "PGID" = "100";
      # "TZ" = "Etc/UTZ";
      # "MEM_LIMIT" = "1024";
      # "MEM_STARTUP" = "1024";
    };
    volumes = [
      "/:/mnt/host:ro"
    ];
    extraOptions = [
      "--network=host"
    ];
    ports = [
      "192.168.1.41:3012:80"
      ];
  };
}

