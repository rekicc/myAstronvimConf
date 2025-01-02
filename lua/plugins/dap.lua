if true then return {} end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    keys = {
       --stylua: ignore
      { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end,
        desc = "Breakpoint Condition",
      },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      -- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
    config = function()
      -------------------------断点图标样式设置-----------------------
      ---颜色设置
      local dap_breakpoint_color = {
        breakpoint = { ctermbg = 0, fg = "#993939", bg = "#31353f" },
        logpoing = { ctermbg = 0, fg = "#61afef", bg = "#31353f" },
        stopped = { ctermbg = 0, fg = "#98c379", bg = "#31353f" },
      }
      vim.api.nvim_set_hl(0, "DapBreakpoint", dap_breakpoint_color.breakpoint)
      vim.api.nvim_set_hl(0, "DapLogPoint", dap_breakpoint_color.logpoing)
      vim.api.nvim_set_hl(0, "DapStopped", dap_breakpoint_color.stopped)

      ---样式设置
      local dap_breakpoint = {
        breakpoint = { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" },
        condition = { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" },
        rejected = { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" },
        logpoint = { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" },
        stopped = { text = "󰳟", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" },
      }
      vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
      vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
      vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
      vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
      vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)

      ---------------------adapter设置------------------------------------
      local dap = require "dap"

      --C/C++/Rust
      -- 下面的方法是通过vscode-cpptools这一扩展,使用gdb进行调试的debug adapter的配置,由于gdb在MacOS系统上需要复杂的配置,远不如使用lldb来的方便快捷,因此注释
      -- 在linux环境下可以运行
      -- dap.adapters.cppdbg = {
      --   id = 'cppdbg',
      --   type = 'executable',
      --   command = '/Users/reki/Program/C/vsCPPToolsExtension/debugAdapters/bin/OpenDebugAD7',
      -- }

      dap.adapters.lldb = {
        id = "lldb",
        type = "executable",
        command = "/usr/local/opt/llvm/bin/lldb-dap",
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "lldb",
          request = "launch",
          program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
        },
        -- {
        --   name = 'Attach to gdbserver :1234',
        --   type = 'cppdbg',
        --   request = 'launch',
        --   MIMode = 'gdb',
        --   miDebuggerServerAddress = 'localhost:1234',
        --   miDebuggerPath = '/usr/bin/gdb',
        --   cwd = '${workspaceFolder}',
        --   program = function()
        --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --   end,
        -- },
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
}
