--- 来源: https://github.com/chaozwn/astronvim_user/blob/astro_v4/lua/plugins/helpview.lua
--- 作用: 美化帮助页面

-- if true then return {} end

return {
  "OXY2DEV/helpview.nvim",
  ft = "help",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
      optional = true,
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "vimdoc" })
        end
      end,
    },
  },
}
