{
  description = "flake for my neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      pkgsFor = nixpkg.lib.genAttrs supportedSystems (system:
        import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        });
  in
  {
    homeModules.default = { config, lib, ... }: {
      config = {
        home.packages = with pkgsFor.${config.system}; [
          neovim 
          gcc
          
          lua-language-server
          kdepackages.qtdeclarative #for qmlls
        ];

        home.file.".config/nvim".source = self.packages.${config.system}.default;
      };

      packages = nixpkgs.lib.genAttrs supportedSystems (system: import ./default.nix { pkgs = pkgsFor.${system} });
    };
  };
}
