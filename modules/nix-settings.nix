{
    pkgs,
    libs,
    ...
}:
{
    nix = {
        settings = {
            # Enable flakes!!! :D
            experimental-features = [
                "nix-command"
                "flakes"
            ];

            # Substituters are considered before the official one (https://cache.nixos.org)
            # Mainly used for the Community binary cache.
            substituters = [
                "https://cache.nixos.org/"
                "https://nix-community.cachix.org"
            ];
            trusted-public-keys = [
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            ];

            # When set to true, Nix instructs remote build machines to use their own substituters if available.
            # Helps reduce build times if local machine to remote's connection is slow
            builders-use-substitutes = true;

            # Only allow the specified users to connect to the nix daemon
            allowed-users = [
                "@wheel"
                "asteria"
            ];

            # Have nix automatically detect files in the store that have identical contents,
            # replaces them with hard links to a single copy.
            auto-optimise-store = true;
        };

        gc = {
            automatic = true;
            options = "--delete-older-than 7d";
        };

        # Automatically run nix store optimiser
        optimise.automatic = true;
    };
}
