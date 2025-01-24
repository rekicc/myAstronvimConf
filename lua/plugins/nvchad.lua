-- if true then return {} end
return {
  {
    "nvchad/ui",
    config = function() require "nvchad" end,
  },

  {
    "nvchad/base46",
    lazy = false,
    build = function() require("base46").load_all_highlights() end,
  },

  "nvchad/volt", -- optional, needed for theme switcher
  -- or just use Telescope themes
  { "nvzone/minty", cmd = { "Shades", "Huefy" } },
  { "nvzone/menu", lazy = true },
}
