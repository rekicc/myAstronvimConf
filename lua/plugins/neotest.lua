--- 来源：https://github.com/chaozwn/astronvim_user/blob/astro_v4/lua/plugins/neotest.lua

-- if true then return {} end

---@type LazySpec
return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
    { "nvim-neotest/nvim-nio", lazy = true },
    {
      "AstroNvim/astroui",
      opts = {
        icons = {
          Tests = "󰗇",
          Watch = "",
        },
      },
    },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings or {}

        local get_file_path = function() return vim.fn.expand "%" end
        local get_project_path = function() return vim.fn.getcwd() end

        local prefix = "<Leader>T"

        maps.n[prefix] = {
          desc = require("astroui").get_icon("Tests", 1, true) .. "Tests",
        }
        maps.n[prefix .. "t"] = {
          function() require("neotest").run.run() end,
          desc = "Run test",
        }
        maps.n[prefix .. "d"] = {
          function() require("neotest").run.run { strategy = "dap" } end,
          desc = "Debug test",
        }
        maps.n[prefix .. "f"] = {
          function() require("neotest").run.run(get_file_path()) end,
          desc = "Run all tests in file",
        }
        maps.n[prefix .. "p"] = {
          function() require("neotest").run.run(get_project_path()) end,
          desc = "Run all tests in project",
        }
        maps.n[prefix .. "<CR>"] = {
          function() require("neotest").summary.toggle() end,
          desc = "Test Summary",
        }
        maps.n[prefix .. "o"] = {
          function() require("neotest").output.open() end,
          desc = "Output hover",
        }
        maps.n[prefix .. "O"] = {
          function() require("neotest").output_panel.toggle() end,
          desc = "Output window",
        }
        maps.n["]T"] = {
          function() require("neotest").jump.next() end,
          desc = "Next test",
        }
        maps.n["[T"] = {
          function() require("neotest").jump.prev() end,
          desc = "Previous test",
        }

        local watch_prefix = prefix .. "W"

        maps.n[watch_prefix] = {
          desc = require("astroui").get_icon("Watch", 1, true) .. "Watch",
        }
        maps.n[watch_prefix .. "t"] = {
          function() require("neotest").watch.toggle() end,
          desc = "Toggle watch test",
        }
        maps.n[watch_prefix .. "f"] = {
          function() require("neotest").watch.toggle(get_file_path()) end,
          desc = "Toggle watch all test in file",
        }
        maps.n[watch_prefix .. "p"] = {
          function() require("neotest").watch.toggle(get_project_path()) end,
          desc = "Toggle watch all tests in project",
        }
        maps.n[watch_prefix .. "S"] = {
          function()
            --- NOTE: The proper type of the argument is missing in the documentation
            ---@see https://github.com/nvim-neotest/neotest/blob/master/doc/neotest.txt#L626-L632
            ---@diagnostic disable-next-line: missing-parameter
            require("neotest").watch.stop()
          end,
          desc = "Stop all watches",
        }
      end,
    },
  },
  config = function(_, opts)
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, vim.api.nvim_create_namespace "neotest")
    require("neotest").setup(opts)
  end,
  opts = {
    status = { virtual_text = true },
    output = { open_on_run = true },
  },
}
