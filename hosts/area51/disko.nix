{
  fileSystems."/nix".neededForBoot = true;

  disko.devices.nodev = {
    "/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=25%"
        "mode=755"
      ];
    };
  };

  disko.devices.disk.main = {
    device = "/dev/nvme0n1";
    type = "disk";

    content = {
      type = "gpt";

      partitions = {
        esp = {
          name = "ESP";
          size = "1G";
          type = "EF00";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };

        swap = {
          size = "34G";

          content = {
            type = "swap";
            resumeDevice = true;
          };
        };

        root = {
          name = "root";
          size = "600G";

          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];

            subvolumes = {
              "/preserved" = {
                mountOptions = [ "subvol=preserved" "noatime" ];
                mountpoint = "/preserved";
              };

              "/nix" = {
                mountOptions = [ "subvol=nix" "noatime" ];
                mountpoint = "/nix";
              };
            };
          };
        };
      };
    };
  };
}
