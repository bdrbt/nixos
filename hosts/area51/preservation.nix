{
  boot.tmp.cleanOnBoot = true;

  preservation = {
    enable = true;

    preserveAt."/preserved" = {
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/systemd/timers"
        "/var/lib/nixos"
        "/var/lib/bluetooth"
        "/var/log"
        {
          directory = "/tmp";
          mode = "0777";
        }
      ];

      users.bdrbt = {
        files = [
          ".zshrc"
        ];

        directories = [
          # configs
          ".ssh"

          ".config/zsh"

          ".config/nvim"
          ".local/state/nvim"
          ".local/share/nvim"

          ".config/niri"
          ".config/mozilla"
          ".config/fuzzel"
          ".config/yazi"

          # common
          "development"
          "dox"
          "media"
          "downloads"
        ];
      };
    };
  };
}
