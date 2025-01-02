--go.nvim设置
return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      run_in_floaterm = true,
      --因为go.nvim内置了nvim-dap-ui的支持,所以在nvim-dap-ui其自身中设置布局是无用的,必须通过go.nvim自身的变量来改变布局
      dap_debug_gui = {
        layouts = {
          {
            elements = {
              { id = "breakpoints", size = 0.25 },
              { id = "watches", size = 0.2 },
              { id = "stacks", size = 0.2 },
              { id = "scopes", size = 0.4 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.95 },
            },
            position = "bottom",
            size = 10,
          },
        },
      },
      --icons = { breakpoint = "", currentpos = "🏃"},
      icons = false,
      --设置为false后侧边栏提示错误和警告的标志使用NvChad提供的,比较美观
      diagnostic = false,
    },
    --event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
