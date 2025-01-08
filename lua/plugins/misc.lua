--- 用于添加配置不是很多的小插件, 以及更改astronvim的一些默认设置

---@type LazySpec
return {
  --- 取词翻译工具
  { "bujnlc8/vim-translator", lazy = true },
  {
    "ianva/vim-youdao-translater",
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<C-t>"] = { "<cmd>Ydc<CR>", desc = "Youdao translator" },
          },
        },
      },
    },
  },

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

  --------------------------astronvim自带插件关闭------------------------------
  --- UI改进插件(?)
  { "stevearc/dressing.nvim", enabled = false },
  --- 自动闭合html之类文件的tag
  { "windwp/nvim-ts-autotag", enabled = false },
  --- 在一种类型的文件中内嵌另一种类型的情况下, 进行注释
  { "JoosepAlviste/nvim-ts-context-commentstring", enabled = false },
  --- 补全提示框显示各个补全项的类型, V5版本默认已经删除这个插件
  { "onsails/lspkind.nvim", enabled = false },
  --- 在颜色代码下显示对应的颜色, V5版本换成了nvim-highlight-colors
  { "NvChad/nvim-colorizer.lua", enabled = false },
  --- 自动显示当前光标下的单词在文件中的其他位置
  { "RRethy/vim-illuminate", enabled = false },
  --- 高亮TODO
  { "folke/todo-comments.nvim", event = "VeryLazy" },
  --- 将非焦点窗口调暗
  { "levouh/tint.nvim", event = "VeryLazy" },
  { "folke/which-key.nvim", opts = { preset = "modern" } },
}
