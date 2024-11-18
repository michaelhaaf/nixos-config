{ pkgs, ... }:

with pkgs; [
  # General packages for development and system management
  alacritty
  aspell
  aspellDicts.en
  bash-completion
  bat
  btop
  coreutils
  difftastic
  du-dust
  fzf
  neofetch
  openssh
  pandoc
  sqlite
  wget
  zellij
  zip

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2
  pass

  # Utilities
  stow
  gnumake
  parallel
  chezmoi

  # SDKs
  gcc
  zig
  go
  gopls
  ngrok
  terraform
  terraform-ls
  tflint
  cargo
  rustc
  swi-prolog
  ghc
  cabal-install

  # quarto
  quarto
  R
  perl
  ruby

  # Media-related packages
  emacs-all-the-icons-fonts
  imagemagick
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  glow
  hack-font
  jpegoptim
  meslo-lgs-nf
  noto-fonts
  noto-fonts-emoji
  pngquant
  fira
  fira-code

  # Node.js development tools
  nodePackages.live-server
  nodePackages.nodemon
  nodePackages.prettier
  nodePackages.npm
  nodejs
  gjs
  bun
  typescript
  eslint

  # Source code management, Git, GitHub tools
  gh
  act
  codeberg-cli

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jetbrains-mono
  jetbrains.phpstorm
  jq
  yq
  ripgrep
  slack
  tree
  tmux
  unrar
  unzip
  zsh-powerlevel10k

  # Python packages
  black
  python3
  virtualenv

  # PDF
  zathura
  pdftk
  ghostscript
]
