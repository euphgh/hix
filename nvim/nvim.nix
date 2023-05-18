{ pkgs, lib, config, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      nvim-web-devicons

      nightfox-nvim
      onenord-nvim
      nord-nvim

      lualine-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      nvim-lspconfig
      # fcitx-vim
      todo-comments-nvim
      hop-nvim
      # nvim-treesitter.withPlugins ( plg: with plg; [ nix lua c cpp python ])
      nvim-ts-rainbow
      nvim-autopairs
      luasnip
      friendly-snippets
      nvim-autopairs
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp_luasnip
      vim-visual-multi
      nvim-cmp
      vim-tmux-navigator
      vim-unimpaired
      vim-surround
      auto-session
      nvim-metals
      markdown-preview-nvim
      (nvim-treesitter.withPlugins (plg: (with plg; [ 
      nix 
      lua 
      c 
      cpp 
      make
      gitignore
      python
      scala
      # sql
      json
      # markdown
      yaml
      vim
      ])))
      comment-nvim
      bufferline-nvim
      symbols-outline-nvim
    ];
  };

  xdg.configFile."nvim/init.vim".source = ./config/init.vim;
  xdg.configFile."nvim/lua".source = ./config/lua;
  home.packages = with pkgs; [
    fd
    ripgrep
    # systemverilog
    # svls
    # SQL
    # sqls

    # TeX
    # texlab

    # Nix
    nil
    nixpkgs-fmt

    # Lua
    sumneko-lua-language-server

    # Python
    # pyright

    # scala
    # coursier
    # metals

    #markdown
    # marksman
    ]++(with pkgs.llvmPackages_15; [
    clang-tools
  ]);
}
