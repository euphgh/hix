{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      nvim-web-devicons
      nord-nvim
      lualine-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      nvim-lspconfig
      fcitx-vim
      todo-comments-nvim
      hop-nvim
      nvim-ts-rainbow
      nvim-autopairs
      luasnip
      friendly-snippets
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
      json
      markdown
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
    svls

    # TeX
    # texlab

    # Nix
    nil

    # Lua
    sumneko-lua-language-server

    # Python
    pyright

    #markdown
    marksman
    ]++(with pkgs.llvmPackages_15; [
    clang-tools
  ]);
}
