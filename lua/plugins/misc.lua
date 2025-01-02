--- 用于添加配置不是很多的小插件
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "go",
        "bash",
        "python",
        "c",
      },
    },
  },

  --取词翻译工具
  { "bujnlc8/vim-translator", lazy = true },
  { "ianva/vim-youdao-translater", keys = { { "<C-t>", "<cmd>Ydc<CR>", desc = "Youdao translator" } }, opts = {} },

  --插入模式中使用jk或者jj退出插入模式
  { "max397574/better-escape.nvim", event = "InsertEnter" },

  --
  --查看git diff信息
  { "sindrets/diffview.nvim", lazy = true },

  --
  --leetcode刷题
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
}
