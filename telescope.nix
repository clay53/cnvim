{pkgs, ...}:
{
  plugins.telescope.enable = true;
  keymaps = [
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
  ];
  extraPlugins = [
    pkgs.vimPlugins.plenary-nvim
  ];
}
