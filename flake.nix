{
  description = "Flake for Clayton's Neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvimFlake = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixvimFlake }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      nixvimLib = nixvimFlake.lib.x86_64-linux;
      nixvim = nixvimFlake.legacyPackages.x86_64-linux;
      nixvimModule = {
        inherit pkgs;
        module = {
          colorschemes.catppuccin.enable = true;
          plugins = {
            telescope = {
              enable = true;
              batPackage = pkgs.ripgrep;
            };
            web-devicons.enable = true;
            treesitter = {
              enable = true;
              settings = {
                highlight = {
                  enable = true;
                };
              };
            };
            harpoon = {
              enable = true;
              enableTelescope = true;
            };
            undotree.enable = true;
            fugitive.enable = true;
            lsp = {
              enable = true;
              keymaps = {
                lspBuf = {
                  "gD" = "declaration";
                  "gd" = "definition";
                  "K" = "hover";
                  "gi" = "implementation";
                  "<C-k>" = "signature_help";
                  "<leader>wa" = "add_workspace_folder";
                  "<leader>wr" = "remove_workspace_folder";
                  "<leader>D" = "type_definition";
                  "<leader>rn" = "rename";
                  "<leader>ca" = "code_action";
                  "gr" = "references";
                };
                diagnostic = {
                  "<leader>e" = "open_float";
                  "[d" = "goto_prev";
                  "]d" = "goto_next";
                  "<leader>q" = "setloclist";
                };
              };
              servers = {
                rust_analyzer = {
                  enable = true;
                  #installCargo = true;
                  #installRustc = true;
                  installCargo = false;
                  installRustc = false;
                };
                ts_ls.enable = true;
                cssls.enable = true;
                jsonls.enable = true;
                html.enable = true;
                bashls.enable = true;
                marksman.enable = true;
                phpactor.enable = true;
                nil_ls.enable = true;
                ocamllsp = {
                  enable = true;
                  #package = pkgs.ocamlPackages.lsp;
                  package = null;
                };
                zls.enable = true;
                ltex = {
                  enable = true;
                  filetypes = [ "html" ];
                };
                gopls = {
                  enable = true;
                };
                dotls.enable = true;
                clangd.enable = true;
              };
            };
            cmp = {
              enable = true;
              settings = {
                completion = {
                  completeopt = "menu,menuone,noinsert";
                };
                autoEnableSources = true;
                performance = {
                  debounce = 60;
                  fetchingTimeout = 200;
                  maxViewEntries = 30;
                };
                snippet = { 
                  expand = ''
                    function(args)
                      require('luasnip').lsp_expand(args.body)
                    end
                  '';
                };
                formatting = { fields = [ "kind" "abbr" "menu" ]; };
                sources = [
                  { name = "nvim_lsp"; }
                  { name = "emoji"; }
                  {
                    name = "buffer"; # text within current buffer
                    option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
                    keywordLength = 3;
                  }
                  {
                    name = "path"; # file system paths
                    keywordLength = 3;
                  }
                  {
                    name = "luasnip"; # snippets
                    keywordLength = 3;
                  }
                ];
              
                window = {
                  completion = { border = "solid"; };
                  documentation = { border = "solid"; };
                };
              
                mapping = {
                  #"<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
                  "<C-j>" = "cmp.mapping.select_next_item()";
                  "<C-k>" = "cmp.mapping.select_prev_item()";
                  "<C-e>" = "cmp.mapping.abort()";
                  "<C-b>" = "cmp.mapping.scroll_docs(-4)";
                  "<C-f>" = "cmp.mapping.scroll_docs(4)";
                  "<C-Space>" = "cmp.mapping.complete()";
                  #"<CR>" = "cmp.mapping.confirm({ select = true })";
                  "<Tab>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
                  "<C-CR>" = "cmp.mapping.confirm({ select = true })";
                  "<C-l>" = ''
                    cmp.mapping(function()
                      if require('luasnip').expand_or_locally_jumpable() then
                        require('luasnip').expand_or_jump()
                      end
                    end, { 'i', 's' })
                  '';
                  "<C-h>" = ''
                    cmp.mapping(function()
                      if require('luasnip').locally_jumpable(-1) then
                        require('luasnip').jump(-1)
                      end
                    end, { 'i', 's' })
                  '';
                };
              };
            };
            cmp-nvim-lsp.enable = true;
            cmp-buffer.enable = true;
            cmp-path.enable = true;
            cmp-cmdline.enable = true;
            luasnip = {
              enable = true;
            };
            cmp_luasnip.enable = true;
            treesitter-context.enable = true;
            nvim-surround.enable = true;
            vimtex = {
              enable = true;
            };
          };
          opts = {
            guicursor = "";
            nu = true;
            relativenumber = true;
            tabstop = 4;
            softtabstop = 4;
            shiftwidth = 4;
            expandtab = true;
            smartindent = true;
            wrap = true;
            swapfile = false;
            backup = false;
            undodir = { __raw = "os.getenv(\"HOME\") .. \"/.vim/undodir\""; };
            undofile = true;
            hlsearch = false;
            incsearch = true;
            termguicolors = true;
            scrolloff = 8;
            signcolumn = "yes";
            updatetime = 50;
            linebreak = true;
            breakindent = true;
            fixeol = false;
          };
          globals = {
            mapleader = " ";
          };
          keymaps = [
            {
              mode = "x";
              key = "<leader>p";
              action = "\"_dP";
            }
            {
              mode = "n";
              key = "<leader>y";
              action = "\"+y";
            }
            {
              mode = "v";
              key = "<leader>y";
              action = "\"+y";
            }
            {
              mode = "n";
              key = "<leader>Y";
              action = "\"+Y";
            }
            {
              mode = "n";
              key = "<leader>d";
              action = "\"_d";
            }
            {
              mode = "v";
              key = "<leader>d";
              action = "\"_d";
            }
            {
              mode = "n";
              key = "Q";
              action = "<nop>";
            }
            {
              mode = "n";
              key = "<leader>pv";
              action = { __raw = "vim.cmd.Ex"; };
            }
            {
              mode = "n";
              key = "<leader>pf";
              action = { __raw = "require(\"telescope.builtin\").find_files, {}"; };
            }
            {
              mode = "n";
              key = "<C-p>";
              action = { __raw = "require(\"telescope.builtin\").find_files, {}"; };
            }
            {
              mode = "n";
              key = "<leader>ps";
              action = { __raw = "function() require(\"telescope.builtin\").grep_string({ search = vim.fn.input(\"Grep > \") }); end"; };
            }
            {
              mode = "n";
              key = "<leader>a";
              action = { __raw = "require(\"harpoon.mark\").add_file"; };
            }
            {
              mode = "n";
              key = "<C-e>";
              action = { __raw = "require(\"harpoon.ui\").toggle_quick_menu"; };
            }
            {
              mode = "n";
              key = "<C-h>";
              action = { __raw = "function () require(\"harpoon.ui\").nav_file(1) end"; };
            }
            {
              mode = "n";
              key = "<C-t>";
              action = { __raw = "function () require(\"harpoon.ui\").nav_file(2) end"; };
            }
            {
              mode = "n";
              key = "<C-n>";
              action = { __raw = "function () require(\"harpoon.ui\").nav_file(3) end"; };
            }
            {
              mode = "n";
              key = "<C-s>";
              action = { __raw = "function () require(\"harpoon.ui\").nav_file(4) end"; };
            }
            {
              mode = "n";
              key = "<leader>u";
              action = { __raw = "vim.cmd.UndotreeToggle"; };
            }
            {
              mode = "n";
              key = "<leader>gs";
              action = { __raw = "vim.cmd.Git"; };
            }
          ];
        };
      };
      nvim = nixvim.makeNixvimWithModule nixvimModule;
    in
  {
    checks.x86_64-linux.default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
    packages.x86_64-linux.default = nvim;
  };
}
