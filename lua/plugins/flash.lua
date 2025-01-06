--- 来源: https://github.com/chaozwn/astronvim_user/blob/astro_v4/lua/plugins/flash.lua

-- if true then return {} end

---@type LazySpec
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    label = {
      uppercase = false,
    },
    modes = {
      char = {
        enabled = false,
      },
    },
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    {
      "S",
      mode = { "n", "x", "o" },
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter",
    },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    {
      "R",
      mode = { "o", "x" },
      function() require("flash").treesitter_search() end,
      desc = "Treesitter Search",
    },
    {
      "<C-s>",
      mode = { "c" },
      function() require("flash").toggle() end,
      desc = "Toggle Flash Search",
    },
  },
}
