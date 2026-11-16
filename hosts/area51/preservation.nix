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
          ".zsh_history"
        ];

        directories = [
          # configs
          ".ssh"

          ".config/nix"

          ".config/nvim"
          ".local/state/nvim"
          ".local/share/nvim"

          ".local/share/TelegramDesktop"
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
