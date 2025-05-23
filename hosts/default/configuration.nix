# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # USe latsest Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  environment.extraOutputsToInstall = [ "dev" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";
  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
  	enable = true;
	};
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
  	enable = true;
	wayland.enable = true;
	};
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  users.groups.ldap = {};


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.muller = {
    isNormalUser = true;
    description = "muller";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
#   nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";


    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";

  };
  hardware.cpu.intel.updateMicrocode = true;
  hardware = {
    graphics.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [

  	# System Wide Utils and drivers
	alsa-utils
	alsa-ucm-conf
	sof-firmware
	networkmanagerapplet
    	libnotify
    	brightnessctl
	wl-clipboard
	neofetch
	unzip
    	zlib
	zziplib
	minizip
	dnsutils
	whois
	inetutils
	net-snmp
	openvpn
	blueman
	pavucontrol
    	tree

	# Display/UI integration (Hyprland)
	waybar
    	dunst
    	swww
    	rofi-wayland
    	swaynotificationcenter
	hyprsunset
    	hyprshot
      	kdePackages.dolphin

	#Core dev Utilities
	vim
	docker_26
	nodejs_23
	git
	docker-compose
	jdk
	ripgrep
	gcc

	# Build Tools
	cmake
	bear
	gnumake

	#GUI Apps
	chromium
	brave
	obsidian
	vlc
	wireshark
	patchelf
	neovim
	alacritty
	
	# Graphics and OpenGL stack
	xorg.libX11
    	xorg.libXi
    	mesa
    	libGLU
    	xorg.libXrandr
    	xorg.libXext
    	xorg.libXcursor
    	xorg.libXinerama
    	pkg-config
    	freeglut
    	glew
    	glfw
    	glm
    	libao
    	mpg123
    	glsl_analyzer


  ];
  programs.thunar.enable = true;
  programs.xfconf.enable = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  nixpkgs.overlays = [
    (final: prev:{
    	konsole = pkgs.emptyPackage;
    })
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  environment.sessionVariables.ALSA_CONFIG_UCM2 = "${pkgs.alsa-ucm-conf}/share/alsa/ucm2";
  hardware.alsa.enablePersistence = true;
  virtualisation.docker.enable = true;
  environment.variables.TERMINAL = "alacritty";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
