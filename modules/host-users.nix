
{ hostname, username, shell, fullName, pkgs, ... }:

#############################################################
#
#  Host & Users configuration
#
#############################################################

{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  users.users."${username}"= {
    # Create the home directory when creating the user
    createHome = true;
    home = "/Users/${username}";
    description = fullName;

    # Cannot be changed if user exists
    shell = pkgs.${shell};
  };
  system.primaryUser = username;

  nix.settings.trusted-users = [ username ];
}
