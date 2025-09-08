{ pkgs ? import <nixpkgs> {} }: pkgs.stdenv.mkDerivation rec {
  pname = "nvim-config";
  version = "0.1";

  src = ./.;

  installPhase = ''
    mkdir -p $out/.config/nvim/lua
    cp -r $src/lua $out/.config/nvim/
    cp -r $src/init.lua $out/.config/nvim
  '';
}
