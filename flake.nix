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
    homeModules.default = { config, lib, ... }: {
      config = {
        programs.neovim = {
          enable = true;
          extraConfig = builtins.readFile ./nvim/init.lua;
        };
        home.packages = with pkgsFor.${config.system}; [
          neovim
          gcc
          lua-language-server
          nixd
        ];
      };
    };

    devShells = nixpkgs.lib.genAttrs supportedSystems (system:
      let 
        pkgs = pkgsFor.${system};
        basePackages = with pkgs; [
          neovim
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
