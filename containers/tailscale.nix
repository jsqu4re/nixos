{ config, pkgs, ... }:

{
  containers."tailscale" = {
    autoStart = true;
    macvlans = [ "enp1s0" ];

    config = {
      environment.variables = rec {
        TS_USERSPACE="true";
        # TS_TAILSCALED_EXTRA_ARGS="--tun=userspace-networking";
        TS_OUTBOUND_HTTP_PROXY_LISTEN="true";
        TS_STATE_DIR="/var/lib/tailscale";
      };
      networking.interfaces."mv-enp1s0".ipv4.addresses = [ { address = "192.168.1.240"; prefixLength = 24; } ];

      # boot.isContainer = true;
      # networking.useDHCP = true;
      networking.firewall.enable = false;
      networking.defaultGateway = "192.168.1.1";

      environment.systemPackages = [ pkgs.tailscale ];

      services.tailscale.enable = true;

      systemd.services.tailscale-autoconnect = {
        description = "Automatic connection to Tailscale";

      # make sure tailscale is running before trying to connect to tailscale
      after = [ "network-pre.target" "tailscale.service" ];
      wants = [ "network-pre.target" "tailscale.service" ];
      wantedBy = [ "multi-user.target" ];

      # set this service as a oneshot job
      serviceConfig.Type = "oneshot";

      # have the job run this shell script
      script = with pkgs; ''
      # wait for tailscaled to settle
        sleep 2

      # check if we are already authenticated to tailscale
        status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
        if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
        fi

      # otherwise authenticate with tailscale
        ${tailscale}/bin/tailscale up -authkey tskey-auth-kfQsAW1CNTRL-F9TgLf5NeT1MFD4NN6xcS1R6zB79uhfZ
      '';
      };

      system.stateVersion = "23.05";
    };
  };
}
