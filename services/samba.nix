{ config, pkgs, ... }:

{
  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
  services.samba-wsdd.discovery = true;
  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.1. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      jsqu4re = {
	path = "/data/samba/jsqu4re";
	browseable = "yes";
	"read only" = "no";
	"guest ok" = "no";
	"create mask" = "0644";
	"directory mask" = "0755";
	"force user" = "jsqu4re";
	"force group" = "users";
      };
      birthe = {
	path = "/data/samba/birthe";
	"valid users" = "birthe";
	public = "no";
	writeable = "yes";
	"force user" = "birthe";
	"fruit:aapl" = "yes";
	"fruit:time machine" = "yes";
	"vfs objects" = "catia fruit streams_xattr";
      };
      public = {
        path = "/data/samba/public";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "jsqu4re";
        "force group" = "users";
      };
    };
  };
}

