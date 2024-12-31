{
  config,
  pkgs,
  services,
  ...
}:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sander";
  home.homeDirectory = "/home/sander";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Git and co.
  programs.git = {
    enable = true;
    extraConfig.credential.helper = "manager";
    extraConfig.credential."https://github.com".username = "sanderman01";
    extraConfig.credential.credentialStore = "cache";
  };

  # Ripgrep
  programs.ripgrep.enable = true;

  # Neovim text editor
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      
    ];
  };

  # Helix text editor
  programs.helix = {
    enable = true;
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
      }
    ];
  };

  # Terminal
  programs.kitty.enable = true;

  # Terminal file manager
  programs.yazi.enable = true;

  # Interactive cmdline cheatsheets
  programs.navi.enable = true;

  # Beets music manager
  programs.beets.enable = true;

  # Direnv
  programs.bash.enable = true;
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # System packages and terminal fonts
  home.packages = with pkgs; [
    git
    git-credential-manager
    pkgs.discord
    (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Source Sans 3" ];
      monospace = [ "Iosevka NFM Medium" ];
    };
  };

}
