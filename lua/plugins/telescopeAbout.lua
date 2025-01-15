return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    opts = {
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    },
  },
  -- {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   lazy = true,
  --   config = function() require("telescope").load_extension "frecency" end,
  -- },
  -- {
  --   "nvim-telescope/telescope-fzf-native.nvim",
  --   lazy = true,
  --   build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
  --   config = function() require("telescope").load_extension "fzf" end,
  -- },
  --懒加载,未使用,要启用的话需要加到telescope的dependencies中,或者手动load
  {
    "benfowler/telescope-luasnip.nvim",
    lazy = true,
    config = function() require("telescope").load_extension "luasnip" end,
  },
}
