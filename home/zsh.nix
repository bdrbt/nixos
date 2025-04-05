{...}: {
  programs.zsh = {
    enable = true;

    autocd = true;
    enableCompletion = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;

    autosuggestion = {
      enable = true;
    };

    history = {
      size = 5000;
      save = 5000;
    };

    envExtra = ''
      if (( $+commands[go] )); then
        export GOPATH="$HOME/development/go"
        export PATH="$GOPATH/bin:$PATH"
      fi
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
