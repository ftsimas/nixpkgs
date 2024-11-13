{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  git,
  nasm,
  alsa-lib,
  glew,
  glib,
  gtk3,
  libmad,
  libogg,
  libpulseaudio,
  libusb-compat-0_1,
  libvorbis,
  pkg-config,
  udev,
  xorg,
  copyDesktopItems,
  makeDesktopItem,
}:

stdenv.mkDerivation rec {
  pname = "itgmania";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "itgmania";
    repo = "itgmania";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-SAEYkAPNUjGNfNnHfwyOj65i2SpEX0ct/fREob5/6fI=";
  };

  nativeBuildInputs = [
    cmake
    nasm
  ];

  buildInputs = [
    alsa-lib
    git
    glew
    glib
    gtk3
    libmad
    libogg
    libpulseaudio
    libusb-compat-0_1
    libvorbis
    pkg-config
    udev
    xorg.libXtst
    copyDesktopItems
  ];

  postInstall = ''
    mkdir -p $out/bin
    ln -s $out/itgmania/itgmania $out/bin/itgmania

    mkdir -p $out/share/icons/hicolor/scalable/apps/
    ln -s $out/itgmania/Data/logo.svg $out/share/icons/hicolor/scalable/apps/itgmania.svg
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "itgmania";
      desktopName = "ITGmania";
      genericName = "Rhythm and dance game";
      tryExec = "itgmania";
      exec = "itgmania";
      terminal = false;
      icon = "itgmania";
      type = "Application";
      comment = "A cross-platform rhythm video game.";
      categories = [
        "Game"
        "ArcadeGame"
      ];
    })
  ];

  meta = {
    homepage = "https://www.itgmania.com/";
    description = "A fork of StepMania 5.1, improved for the post-ITG community";
    platforms = lib.platforms.linux;
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ftsimas ];
    mainProgram = "itgmania";
  };
}
