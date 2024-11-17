{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [

  # Security and authentication
  yubikey-agent
  pass-wayland
  fuzzel
  tessen

  # App and package management
  appimage-run
  gnumake
  cmake
  home-manager

  # Printers and drivers
  brlaser # printer driver

  # Calculators
  bc

  # Audio tools
  cava # Terminal audio visualizer
  pavucontrol # Pulse audio controls

  # Testing and development tools
  direnv
  qmk
  libusb1 # for Xbox controller
  libtool # for Emacs vterm

  # Text and terminal utilities
  emote # Emoji picker
  tree
  unixtools.ifconfig
  unixtools.netstat

  # File and system utilities
  inotify-tools # inotifywait, inotifywatch - For file system events
  i3lock-fancy-rapid
  libnotify

  # PDF
  zathura
  pdftk
  ghostscript

]
