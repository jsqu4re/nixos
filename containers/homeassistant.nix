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
	  "--network=host"
	  "--privileged"
	];
  };	
}
