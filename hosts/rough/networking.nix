{lib,pkgs,...}: {
  networking.hostName = "rough";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    curl
    wget
    netcat
    dig
    nmap
  ];
}

