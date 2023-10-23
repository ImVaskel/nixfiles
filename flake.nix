{
  description = "My NixOS and home-manager configurations.;";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };
  outputs = {
    self,
    flake-utils,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    mkSystem = {
      hostname,
      system ? "x86_64-linux",
      users,
      flags ? {},
      overrides ? {},
    } @ args: overrides: let
      mkConfig = {
        hostname,
        system ? "x86_64-linux",
        users,
        flags ? {},
      }: rec {
        inherit system;
        specialArgs = {
          inherit hostname inputs flags;
        };
        modules = [
          ./hosts/${hostname}/configuration.nix
          ./mixins/nix.nix
          inputs.vscode-server.nixosModules.default
          {
            system.stateVersion = "23.05";
            services.dbus.enable = true;
            services.vscode-server.enable = true;
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.verbose = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.sharedModules = [
              {home.stateVersion = "23.05";}
            ];
            home-manager.users = users;
          }
        ];
      };
    in
      nixpkgs.lib.nixosSystem ((mkConfig args) // overrides (mkConfig args));
  in
    {
      nixosConfigurations.nova = (mkSystem {
        hostname = "nova";
        users = {vaskel = ./home;};
        flags = {
          headless = true;
        };
      }) (_: {});
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter = pkgs.alejandra;

      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          alejandra # formatter
          nil # LSP
        ];
      };
    });
}
