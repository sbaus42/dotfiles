local plugins = {
  {
    "psliwka/vim-smoothie",
    lazy = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- VERY IMPORTANT
    config = function()
      require("catppuccin").setup({
        integrations = {
          telescope = true,
          treesitter = true,
          lualine = true,
        },
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  }
}

return plugins

