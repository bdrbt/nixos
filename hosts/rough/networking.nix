{lib,...}: {
  networking.hostName = "rough";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
}
