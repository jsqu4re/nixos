# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./containers/homeassistant.nix
      ./containers/ytdl-sub.nix
      ./containers/unifi.nix
      ./containers/tailscale.nix
      ./development/vscode-server.nix
      ./services/samba.nix
      ./services/jellyfin.nix
      ./services/nginx.nix
    ];

    environment.variables.EDITOR = "nvim";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nihil"; # Define your hostname.

  # virtualisation.vlans = [ 1 ];

  networking.macvlans.eth-host = {
    interface = "enp1s0";
    mode = "bridge";
  };

  networking.interfaces.enp1s0.ipv4.addresses = lib.mkForce [];

  networking.interfaces.eth-host = {
    ipv4.addresses = [
      { address = "192.168.1.41"; prefixLength = 24; }
      { address = "192.168.1.220"; prefixLength = 24; }
    ];
  };

  # networking.useDHCP = true;
  networking.defaultGateway = "192.168.1.1";
  # networking.interfaces.enp1s0.useDHCP = false;
  # networking.interfaces.enp1s0.ipv4.addresses = [
  #   { address = "192.168.1.41"; prefixLength = 24; }
  #   { address = "192.168.1.220"; prefixLength = 24; }
  # ];
  #   {
  #     address = "192.168.1.240";
  #     prefixLength = 24;
  #   }
  # ];

  # networking.interfaces.veth0.macAddress = "AA:00:00:00:00:01";
  # networking.interfaces.veth0.virtual = true;
  # networking.interfaces.veth0.ipv4.addresses = [{ address = "192.168.1.220"; prefixLength = 24; }];

  # networking.bridges.br0.interfaces = [ "enp1s0" ];
  # networking.interfaces.enp1s0.useDHCP = true;
  # networking.interfaces.br0.macAddress = "AA:00:00:00:00:01";
  # networking.interfaces.br0.ipv4.addresses = [{ address = "192.168.1.41"; prefixLength = 24; }];

  # networking.nat = {
  #   enable = true;
  #   internalInterfaces = [ "ve-unifi" ];
  #   externalInterfaces = "br0";
  # };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  virtualisation.podman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jsqu4re = {
    isNormalUser = true;
    description = "Johannes";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      ncdu
      git
      htop
      tmux
      ranger
      fzf
    ];
  };

  users.users.birthe = {
    isNormalUser = true;
    description = "Birthe";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      htop
      ncdu
      ranger
      git
    ];
  };

  users.users.jellyfin = {
    isSystemUser = true;
    description = "service user for jellyfin";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    (neovim.override {
      vimAlias = true;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [ vim-lastplace vim-nix ]; 
          opt = [];
        };
      };
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    80 433 # Nginx
    88 8123 # Home Assistant
    445 139 5357 # Samba
    8443 8080 8843 8880 6789
  ];
  networking.firewall.allowedUDPPorts = [
    137 138 3702 # Samba
    3478 10001 1900 5514
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
