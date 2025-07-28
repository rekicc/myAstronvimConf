--DAP UI界面设置
return {
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    opts = {
      enabled = true,
      enable_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      filter_references_pattern = "<module",
      virt_text_pos = "eol",
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil,
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    specs = {
      ---@type AstroCoreOpts
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>d" .. "f"] = {
          function() require("dapui").float_element "console" end,
          desc = "Open the console window",
        }
      end,
    },
    -- stylua: ignore
      -- keys = {
      --   { "<leader>du", function() require("dapui").toggle {} end, desc = "Dap UI", },
      --   { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" }, },
      -- },
    --配置dap-ui的布局
    opts = {
      layouts = {
        {
          elements = {
            { id = "breakpoints", size = 0.2 },
            { id = "watches", size = 0.2 },
            { id = "stacks", size = 0.2 },
            { id = "scopes", size = 0.4 },
          },
          position = "left",
          size = 40,
        },
        {
          elements = { { id = "repl", size = 0.95 } },
          position = "bottom",
          size = 10,
        },
      },
    },
    --配置dap-ui在调试开始或结束时自动出现或消失
    -- config = function(_, opts)
    --   local dap = require "dap"
    --   local dapui = require "dapui"
    --   dapui.setup(opts)
    --   dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
    --   dap.listeners.before.attach["dapui_config"] = function() dapui.open() end
    --   dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
    --   dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end
    -- end,
  },
}
