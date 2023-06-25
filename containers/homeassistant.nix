{ config, pkgs, ... }:

{
  # Home Assistant
  virtualisation.oci-containers.containers."homeassistant" = {
    autoStart = true;
    image = "ghcr.io/home-assistant/home-assistant:stable";
    volumes = [
      "/home/jsqu4re/HomeAssistant:/config"
      "/etc/localtime:/etc/localtime:ro"
    ];
    extraOptions = [
      "--ip=192.168.1.235"
      "--mac-address=02:00:00:00:00:01"
      "--privileged"
      "--network=eth-host"
    ];
  };	
}
