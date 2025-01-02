return {
  {
    "olimorris/onedarkpro.nvim",
    opts = {
      highlights = {
        PmenuSel = { bg = "#1A5CA4" },
      },
      styles = {
        conditionals = "italic",
        virtual_text = "italic",
        comments = "italic",
      },
      options = {
        transparency = true,
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
}
