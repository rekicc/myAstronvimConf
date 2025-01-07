return {
  {
    "olimorris/onedarkpro.nvim",
    opts = {
      highlights = {
        --- 弹出窗口中的选中项
        PmenuSel = { bg = "#1A5CA4" },
        --- Telescope窗口的标题
        TelescopeTitle = { fg = "#64ff81" },
        --- 行号
        LineNr = { fg = "#54950d", bg = "#000000" },
        --- 折叠栏
        FoldColumn = { fg = "#54950d", bg = "#000000" },
        --- visual模式选中部分
        Visual = { bg = "#063870" },
      },
      styles = {
        conditionals = "italic",
        virtual_text = "italic",
        -- comments = "italic",
      },
      options = {
        transparency = false,
        -- highlight_inactive_windows = true,
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
  }, lazy = true },
}
