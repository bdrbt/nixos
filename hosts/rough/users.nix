{pkgs,...}: {
  users.users.dmitry = {
    initialPassword = "initialpassword";
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "podman"];
  };
}
