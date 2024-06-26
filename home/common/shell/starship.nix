{pkgs, ...}: {
  # Set up transient prompt
  programs.fish.interactiveShellInit = ''
    eval (starship init fish)
    enable_transience

    function starship_transient_prompt_func
      starship module character
    end
  '';

  programs.starship = {
    enable = true;
    enableFishIntegration = false; # managed ourselves
    enableBashIntegration = false; # i don't use bash, but this breaks it too.
    settings = {
      # Kinda cursed, but it's w/e
      format =
        (builtins.replaceStrings ["\n"] [""] ''
          [](bg: #078d70)
          $username$hostname
          [](fg:#078d70 bg:#26ceaa)
          $directory
          [](fg:#26ceaa bg:#99e8c2)
          $git_branch$git_commit$git_state$git_status
          [ ](bg:#99e8c2)
          [](fg:#99e8c2 bg:#7bade3)
          $c
          $cmake
          $dart
          $deno
          $dotnet
          $elixir
          $erlang
          $golang
          $haskell
          $java
          $kotlin
          $lua
          $nodejs
          $python
          $ruby
          $rust
          $swift
          $package
          [ ](bg:#7bade3)
          [](fg:#7bade3 bg:#5049cb)
          $cmd_duration
          [ ](bg:#5049cb)
          [](fg:#5049cb bg:#3e1a78)
          $time
          [](fg:#3e1a78)
        '')
        + "\n$character";

      username = {
        style_user = "bg:#078d70 fg:#000000";
        style_root = "bg:#078d70 fg:#000000";
        show_always = true;
        format = "[$user ]($style)";
      };

      hostname = {
        style = "bg:#078d70 fg:#000000";
        format = "[\uf178  ssh: $hostname ]($style)";
      };

      directory = {
        truncation_symbol = "…/";
        truncation_length = 5;
        style = "bg:#26ceaa fg:#000000";
        format = "[ $path ]($style)";
      };
      git_branch = {
        symbol = "";
        style = "bg:#99e8c2 fg:#000000";
        format = "[ $symbol $branch(:$remote_branch)]($style)";
      };

      git_commit = {
        tag_symbol = " ";
        style = "bg:#99e8c2 fg:#000000";
        format = "[ \\($hash$tag\\)]($style)";
      };

      git_state = {
        style = "bg:#99e8c2 fg:#000000";
        format = "[$state ($progress_current/$progress_total)]($style)";
      };

      git_status = {
        style = "bg:#99e8c2 fg:#000000";
        format = "[($all_status$ahead_behind)]($style)";
      };

      c = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version(-$name))]($style)";
      };

      cmake = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      dart = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      deno = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      dotnet = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)( 🎯$tfm)]($style)";
      };

      elixir = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version \\(OTP $otp_version\\))]($style)";
      };

      erlang = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      golang = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      haskell = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      java = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      kotlin = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      lua = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      nodejs = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      python = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ \${symbol}\${pyenv_prefix}(\${version} )(\\($virtualenv\\))]($style)";
      };

      ruby = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      rust = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      swift = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      package = {
        style = "bg:#7bade3 fg:#000000";
        format = "[ $symbol($version)]($style)";
      };

      cmd_duration = {
        style = "bg:#5049cb fg:#000000";
        format = "[ $duration]($style)";
      };

      time = {
        disabled = false;
        time_format = "%I:%M %P";
        style = "bg:#3e1a78 fg:#000000";
        format = "[ ♥ $time ]($style)";
      };

      character = {
        success_symbol = " [](fg:#078d70) ";
        error_symbol = " [✘](bold red) ";
      };
    };
  };
}
