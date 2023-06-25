{ config, pkgs, ... }:

{
  # ytdl-sub
  virtualisation.oci-containers.containers."ytdlsub" = {
    autoStart = true;
    image = "ghcr.io/jmbannon/ytdl-sub:latest";
    environment = {
      "PUID" = "995";
      "PGID" = "993";
      "TZ" = "America/Los_Angeles";
      "DOCKER_MODS" = "linuxserver/mods:universal-cron";
    };
    volumes = [
      "/home/jsqu4re/workspace/yt/config:/config"
      "/data/jellyfin/shows:/tv-shows"
    ];
    extraOptions = [
      "--network=host"
    ];
  };	
}
