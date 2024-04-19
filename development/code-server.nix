{ config, pkgs, ... }:

{
  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-16.20.1"
  ];

  services.code-server = {
    enable = true;
    user = "jsqu4re";
    group = "users";
  };
}
