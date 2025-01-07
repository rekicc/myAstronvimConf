-- if true then return {} end
--mini.nvim,一系列的提升体验的插件列表,可以按需开启
return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      -- require("mini.animate").setup()
      require("mini.icons").setup()
      require("mini.surround").setup()
      -- require("mini.ai").setup()
      -- require("mini.jump").setup()
      -- require("mini.sessions").setup()
    end,
  },
}
