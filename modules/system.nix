{ pkgs, ... }:

  ###################################################################################
  #
  #  macOS's System configuration
  #
  #  All the configuration options are documented here:
  #    https://nix-darwin.github.io/nix-darwin/manual/index.html#sec-options
  #
  ###################################################################################
{
  system = {
    stateVersion = 6;

    defaults = {
      # System-wide alert sound. Found under "Sound Effects" in the "Sound" section of "System Prefereneces"
      # Set to Submerge
      ".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/Submarine.aiff";

      NSGlobalDomain = {
        # Icon and widget style
        AppleIconAppearanceTheme = "RegularAutomatic";

        # Interface style
        # If set to dark, requires user to manually run `defaults delete -g AppleInterfaceStyle` to change
        AppleInterfaceStyle = null;

        # Whether to automatically switch between light and dark mode
        AppleInterfaceStyleSwitchesAutomatically = false;

        # Press and Hold for Accents
        ApplePressAndHoldEnabled = true;

        # Jumpt to the spot that's click on the scroll bar
        AppleScrollerPagingBehavior = true;

        # Whether to show all file extensions in Finder.
        AppleShowAllExtensions = true;

        # When to show the scrollbars. Options are ‘WhenScrolling’, ‘Automatic’ and ‘Always’.
        AppleShowScrollBars = "Automatic";

        # Enable automatic capitalization
        NSAutomaticCapitalizationEnabled = true;

        # Disable period substitution, 'cause i hate it.
        NSAutomaticPeriodSubstitutionEnabled = false;

        # Enable expanded save panel by default
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };

      # Automatically install MacOS software updates
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

      # Click wallpaper to reveal desktop
      WindowManager.EnableStandardClickToShowDesktop = true;

      # Show battery percentage in menu bar
      controlcenter.BatteryShowPercentage = true;

      # dock settings
      dock = {
        # Automatically hide and show the dock
        autohide = true;

        # Minimize windows into their app icon
        minimize-to-application = true;

        # Position of the dock on the screen
        orientation = "right";

        # Four-finger spread gesture to show the Desktop
        showDesktopGestureEnabled = true;

        # Hot corner action for bottom left corner
        # Options: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-br-corner
        wvous-bl-corner = null;

        # Hot corner action for top left corner
        # options: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-tl-corner
        wvous-tl-corner = null;

        # Hot corner action for top right corner
        # options: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-tr-corner
        wvous-tr-corner = null;
      };

      # Finder options
      finder = {
        # Show hard disks on desktop
        ShowHardDrivesOnDesktop = true;

        # Path breadcrumbs
        ShowPathbar = true;

        # Status bar with item/disk space stats
        ShowStatusBar = true;
      };

      # Login window
      loginwindow = {
        # Allow/disallow guest account login
        GuestEnabled = false;

        # Login window text
        LoginwindowText = "Asteria's Macbook Pro";

        # Hide restart button on login screen when a user is logged in
        RestartDisabledWhileLoggedIn = true;

        # Disable shutdown when users are logged in.
        ShutDownDisabledWhileLoggedIn = true;
      };

      # Enable two-finger pinch gesture for zooming in and out
      trackpad.TrackpadPinch = true;

      # Enable trackpad right click
      trackpad.TrackpadRightClick = true;

      # show 24 hour clock
      menuExtraClock.Show24Hour = false;

      # Whether to enable tape to click
      trackpad.Clicking = false;

      # Path to which Screen capture's should be written to
      screencapture.location = "/Users/asteria/Screen Captures";
    };

    # Enable startup chime
    # CAUTION: Can not be unset once set. It *will* allow the setting to be controlled in system settings
    startup.chime = true;
  };


  power = {
    sleep.allowSleepByPowerButton = true;
  };

  
  security = {
    pam = {
      # Add ability to used TouchID for sudo authentication
      services.sudo_local.touchIdAuth = true;
      # enable reattaching a program to a user's bootstrap session
      # fixes Touch ID for sudo not working inside tmux/screen across user sessions
      services.sudo_local.reattach = true;
    };
  };


  programs = {
    # Create /etc/zshrc that loads the nix-darwin environment.
    # this is required if you want to use darwin's default shell - zsh
    zsh.enable = true;

    # Configure fish as an interactive shell
    fish.enable = true;

    # Nix devenv
    # devenv = {
    #   enable = true;
    #   enableFishIntergration = true;
    # };

    # nix-index and command-not-found helper
    nix-index.enable = true;

    vim = {
      enable = true;

      # Sensible vim options
      enableSensible = true;

      vimConfig = "set rnu\nset mouse=a";

      plugins = [
        {
          names = [
            "vim-surround"
            "vim-nix"
          ];
        }
      ];
    };
  };
}
