{
  description = "Nix for macOS configuration";

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin = {
        url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
        inputs.nixpkgs.follows = "nixpkgs";
    };  
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    ...
  }: let
    username = "asteria";
    fullName = "Asteria Christine Hoffmeyer";
    system = "aarch64-darwin"; # aarch64-darwin or x86_64-darwin
    hostname = "Asterias-MacBook-Pro";
    shell = "fish"; # nix pkgs name of desired shell

    specialArgs =
      inputs
      // {
        inherit username fullName hostname shell;
      };
  in {
    darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/nix-settings.nix
        ./modules/system.nix
        ./modules/apps.nix

        ./modules/host-users.nix
      ];
    };
    # nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
