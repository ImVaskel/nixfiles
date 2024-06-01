{pkgs, ...}: let
  homeManger = pkgs.home-manager;
in {
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = "";
      # TODO: Figure out if there is a way to set this up so that i can find the flake path dynamically.
      hm-reload = "${homeManger}/bin/home-manager switch --flake ~/dotfiles-nix/";
    };
    shellAbbrs = {
      ls = "eza";
      la = "eza -a";
      ll = "eza --git -lg --icons";
      lla = "eza --git --lga --icons";
    };
  };
}
