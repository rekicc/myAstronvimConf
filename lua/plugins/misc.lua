--- 用于添加配置不是很多的小插件, 以及更改astronvim的一些默认设置

---@type LazySpec
return {
  --- 取词翻译工具
  { "bujnlc8/vim-translator", lazy = true },
  { "ianva/vim-youdao-translater", keys = { { "<C-t>", "<cmd>Ydc<CR>", desc = "Youdao translator" } }, opts = {} },

  --- 插入模式中使用jk或者jj退出插入模式
  { "max397574/better-escape.nvim", event = "InsertEnter" },

  --- leetcode刷题
  {
    "kawre/leetcode.nvim",
    lazy = true,
    build = ":TSUpdate html",
    dependencies = {

      -- optional
      "rcarriga/nvim-notify",
    },
    opts = {
      -- configuration goes here
    },
  },

  --- customize alpha options
  { "goolord/alpha-nvim", enabled = true },

  { "andweeb/presence.nvim", enabled = false },

  --- 显示函数签名
  {
    "ray-x/lsp_signature.nvim",
    enabled = true,
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  { "stevearc/dressing.nvim", enabled = false },
}
