# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];


  # boot.kernelParams = [ "amd_iommu=on" ];





  # boot.kernelModules = [ "kvm-amd" ];
  # boot.extraModulePackages = [ ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu"];
  # boot.extraModprobeConfig = "options vfio-pci ids=1002:73df,1002:ab28";
  # boot.kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
  # boot.initrd.availableKernelModules = [ "amdgpu" "vfio-pci" ];

#   boot.postBootCommands = ''
#     DEVS="0000:28:00.0 0000:28:00.1"

#     for DEV in $DEVS; do
#       echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
#     done
#     modprobe -i vfio-pci
# '';

  # boot.initrd.availableKernelModules = [ "amdgpu"];
  # boot.initrd.preDeviceCommands = ''
  # DEVS="0000:28:00.0 0000:28:00.1"
  # for DEV in $DEVS; do
  #   echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
  # done
  # modprobe -i vfio-pci
  # '';

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9b4b8fd8-1043-41ce-92c8-2c1af62fb6cc";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/98BA-57AA";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/eae98dbd-6700-4269-af57-5c83231ce48f"; }
    ];

  nix.settings.max-jobs = lib.mkDefault 12;
  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
}
