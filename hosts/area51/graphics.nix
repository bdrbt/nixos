{ config, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # VA-API for modern Intel GPUs (Broadwell+)
      intel-vaapi-driver # Fallback for older Intel GPUs
      libvdpau-va-gl
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # Modesetting is required for Wayland and PRIME
  hardware.nvidia.modesetting.enable = true;

  # Power management: turns off the NVIDIA GPU when not in use (Turing+ / RTX 20xx and newer)
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = true;

  # RTX 5070
  hardware.nvidia.open = false;

  # Enable the nvidia-settings menu
  hardware.nvidia.nvidiaSettings = true;

  # Select the driver package (stable is default; production/beta also available)
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # Hybrid GPU Setup (Intel iGPU/dGPU + NVIDIA dGPU)
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true; # Provides the `nvidia-offload` wrapper command
    };

    # IMPORTANT: Replace these with your actual PCI Bus IDs!
    # Run `nix-shell -p pciutils --run "lspci -d ::03xx"` to find them.
    # Convert hex to decimal (e.g., 00:02.0 -> PCI:0:2:0, 01:00.0 -> PCI:1:0:0)
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # 5. System packages for CUDA development and GPU monitoring
  environment.systemPackages = with pkgs; [
    cudatoolkit
    cudaPackages.cudnn
    nvtopPackages.full # Monitor both Intel and NVIDIA GPUs in terminal
    pciutils
  ];

  # 6. Environment variables so CUDA libraries are discoverable
  environment.sessionVariables = {
    CUDA_PATH = "${pkgs.cudatoolkit}";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
  };

  # Optional: If using Docker/Podman containers with CUDA (e.g., Ollama, PyTorch)
  hardware.nvidia-container-toolkit.enable = false;
}
