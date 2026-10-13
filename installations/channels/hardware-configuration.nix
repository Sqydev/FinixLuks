{ pkgs, ... }:

{
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "dm_mod"
    "dm_crypt"
  ];
  boot.initrd.kernelModules = [ ];

  boot.kernelModules = [ "kvm-<INTEL/AMD>" ];
  boot.extraModulePackages = [ ];

  hardware.firmware = with pkgs; [
    linux-firmware
    sof-firmware
  ];

  fileSystems."/" = {
    device = "/dev/mapper/cryptroot";
    fsType = "ext4";
  };

  fileSystems."cryptroot" = {
    device = "/dev/nvme0n1p2";
    fsType = "luks";
    neededForBoot = true;
    options = [ "--allow-discards" ];
  };

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [  ];
}
