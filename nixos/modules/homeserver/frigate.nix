{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt
    ];
  };
  services.nginx.enable = true;
  services.frigate = {
    enable = true;
    hostname = "homeserver.local";

    settings = {
      mqtt.enabled = false;
      ffmpeg = {
        hwaccel_args = "preset-vaapi";
      };
      cameras = {
        tapo_c200 = {
	  detect = {
	    enabled = false;
	  };
          onvif = {
            host = "192.168.40.168";
            port = 2020;
            user = "{FRIGATE_TAPO_USER}";
            password = "{FRIGATE_TAPO_PASSWORD}";
          };
          ffmpeg = {
            inputs = [
              {
                path = "rtsp://{FRIGATE_TAPO_USER}:{FRIGATE_TAPO_PASSWORD}@192.168.40.168:554/stream1";
                roles = [ "record" ];
              }
            ];
          };
          
          record = {
            enabled = true;
            retain = {
              days = 1;
              mode = "all";
            };
          };
        };
      };
    };
  };

  age.secrets.frigate-env = {
    file = ../../secrets/frigate-env.age; 
  };

  systemd.services.frigate.serviceConfig.SupplementaryGroups = [ "render" "video" ];
  systemd.services.frigate.serviceConfig.EnvironmentFile = [
    config.age.secrets.frigate-env.path
  ];

  networking.firewall.allowedTCPPorts = [ 80 ];
}
