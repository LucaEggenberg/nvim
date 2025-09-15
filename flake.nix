{
  description = "nvim config & devshells";

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

      pkgsFor = nixpkgs.lib.genAttrs supportedSystems (system:
        import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        });
  in
  {
    homeManagerModules.default = { pkgs, config, lib, ... }: 
    let 
      cfg = config.programs.nvim-config;
      inherit (lib) mkOption types;
    in
    {
      options.programs.nvim-config = {
        symlinkPath = mkOption {
          type = types.str;
          default = "${self}/nvim";
          description = "the path to symlink into .config/nvim";
        };
      };

      config = {
        home.packages = with pkgs; [
          neovim
          gcc
          lua-language-server
          nixd
        ];

        home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink cfg.symlinkPath;
      };
    };

    devShells = nixpkgs.lib.genAttrs supportedSystems (system:
      let 
        pkgs = pkgsFor.${system};
        basePackages = with pkgs; [
          gcc
          glibcLocales
        ];
      in
      {
        default = pkgs.mkShell {
          name = "default-dev";
          packages = basePackages ++ [
            pkgs.lua-language-server
            pkgs.nixd
          ];
        };

        quickshell = pkgs.mkShell {
          name = "quickshell-dev";
          packages = basePackages ++ [
            pkgs.kdepackages.qtdeclarative
          ];
          shellHook = ''
            export NVIM_QML_LS=true
          '';
        };

        csharp = pkgs.mkShell {
          name = "csharp-dev";
          packages = basePackages ++ [
            pkgs.dotnet-sdk
            pkgs.omnisharp-roslyn
          ];
          shellHook = ''
            export NVIM_CSHARP_LS=true
          '';
        };
      });
  };
}
