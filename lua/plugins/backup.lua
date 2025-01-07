if true then return {} end

------------安装过的插件记录,留作后用--------------------------------------------------------
--- Go高亮插件,不会使用
--{ "ray-x/aurora" },

--- 另一款Go高亮插件.也无法正常工作,可能与NvChad配置有关
--{ "charlespascoe/vim-go-syntax" },

--- 查找工具, 没有实际启用
--{ "Yggdroot/LeaderF", lazy=true},

--- go语言另一款插件,和vim比较合适
--{ "fatih/vim-go",  },

--- folke大神的插件,好像是用于开发neovim插件的插件,没搞懂怎么用
--{ "folke/lazydev.nvim", ft = "lua" },

---
-- { "voldikss/vim-floaterm" },

--- 加载插件自定义的textobjects
--{ "nvim-treesitter/nvim-treesitter-textobjects", lazy = false },

--- 同时替换开括号与闭括号
--{ "kylechui/nvim-surround", version = "*", event = "VeryLazy" },

--- Sessionc持久化插件
-- { "folke/persistence.nvim",
--   event = "BufReadPre",
--   opts = {},
--   -- stylua: ignore
--   keys = {
--     { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
--     { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
--     { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
--     { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
--   },
-- }
