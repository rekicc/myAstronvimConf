return {
  {
    "olimorris/onedarkpro.nvim",
    opts = {
      highlights = {
        PmenuSel = { bg = "#1A5CA4" },
        TelescopeTitle = { fg = "#64ff81" },
        LineNr = { fg = "#54950d", bg = "#000000" },
        FoldColumn = { fg = "#54950d", bg = "#000000" },
        Visual = { bg = "#063870" },
      },
      styles = {
        conditionals = "italic",
        virtual_text = "italic",
        -- comments = "italic",
      },
      options = {
        transparency = false,
        -- highlights_inactive_windows = true,
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
    opts = {
      transparent_background = true,
      dim_inactive = {
        enabled = true,
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
    },
  },
  { "AstroNvim/astrotheme", opts = {
    style = {
      transparent = false,
      inactive = false,
    },
  } },

  { "folke/tokyonight.nvim", opts = {
    transparent = false,
  } },
}
