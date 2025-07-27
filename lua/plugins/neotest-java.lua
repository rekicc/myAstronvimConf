-- if true then return {} end
return {
  {
    "rcasia/neotest-java", -- Java 测试适配器
    ft = "java",
    enabled = vim.fn.executable "java" == 1,
    dependencies = {
      {
        "nvim-neotest/neotest",
        opts = function(_, opts)
          if not opts.adapters then opts.adapters = {} end
          table.insert(
            opts.adapters,
            require "neotest-java" {
              command = "/home/reki/Workspace/CS61B/2025-spring/gradlew",
              args = "test",
            }
          )
        end,
      },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings or {}

          local prefix = "<Leader>T"

          maps.n[prefix .. "j"] = {
            function() require("jdtls").test_nearest_method() end,
            desc = "run java method test",
          }

          maps.n[prefix .. "J"] = {
            function() require("jdtls").test_class() end,
            desc = "run java class test",
          }
        end,
      },
    },
  },
}
