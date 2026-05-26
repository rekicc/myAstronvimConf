if true then return {} end
return {
  -- {
  --   "nvchad/ui",
  --   config = function() require "nvchad" end,
  -- },
  --
  -- {
  --   "nvchad/base46",
  --   lazy = false,
  --   build = function() require("base46").load_all_highlights() end,
  -- },
  --
  -- { "nvzone/volt", lazy = true }, -- optional, needed for theme switcher
  -- -- or just use Telescope themes
  -- { "nvzone/minty", cmd = { "Shades", "Huefy" }, dependance = { "nvzone/volt" } },
  -- { "nvzone/menu", lazy = true },
  {
    "AvengeMedia/base46",
    lazy = false, -- 必须是非延迟加载，确保启动时主题生效
    priority = 1000, -- 赋予最高优先级
    config = function()
      -- 在这里选择你想要的 NvChad 主题
      -- 可选如：base46-onedark, base46-catppuccin, base46-nord, base46-gruvbox 等
      vim.cmd("colorscheme base46-onedark")
    end,
  },
}
