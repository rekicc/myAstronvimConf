--- 来源: https://github.com/chaozwn/astronvim_user/blob/astro_v4/lua/plugins/snacks.lua

-- if true then return {} end

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      input = { enabled = true },
      debug = { enabled = false },
      indent = {
        enabled = true,
        filter = function(buf)
          local forbidden_filetypes = { "markdown", "markdown.mdx" } -- Add your forbidden filetypes here
          local filetype = vim.bo[buf].filetype
          for _, ft in ipairs(forbidden_filetypes) do
            if filetype == ft then return false end
          end
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
      },
      notifier = { enabled = true },
      scroll = { enabled = true },
      scope = { enabled = true },
      dim = { enabled = true },
      notify = { enabled = true },
      picker = { enabled = true },
      words = { enabled = true },
      profiler = { enabled = true },
      statuscolumn = {
        enabled = true,
        left = { "mark", "sign" },
        right = { "fold", "git" },
        folds = {
          open = false,
          git_hl = false,
        },
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50,
      },
    },
    dependencies = {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local sn = require "snacks"
        local maps = opts.mappings or {}
        maps.n["<Leader>td"] = {
          function()
            local enabled = sn.dim.enabled
            if enabled then
              sn.dim.disable()
            else
              sn.dim.enable()
            end
          end,
          desc = "Toggle dim",
        }
        maps.n["]b"] = {
          function() sn.words.jump(1, false) end,
          desc = "go forward one word",
        }
        maps.n["[b"] = {
          function() sn.words.jump(-1, false) end,
          desc = "go backword one word",
        }
        maps.n["<Leader>fp"] = {
          function() sn.picker.projects() end,
          desc = "find projects",
        }
        -- maps.n["<Leader>fl"] = {
        --   function() sn.picker.cliphist() end,
        --   desc = "find clipboard history",
        -- }
        maps.n["<Leader>fL"] = {
          function() sn.picker.lines() end,
          desc = "find lines",
        }
        maps.n["<Leader>fH"] = {
          function() sn.picker.highlights() end,
          desc = "find highlights",
        }
        maps.n["<Leader>fi"] = {
          function() sn.picker.icons() end,
          desc = "find icons",
        }
        maps.n["<Leader>fs"] = {
          function() sn.picker.smart() end,
          desc = "smart find",
        }
        maps.n["<Leader>fu"] = {
          function() sn.picker.undo() end,
          desc = "find undo",
        }
      end,
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts) opts.statuscolumn = false end,
  },
  { "rcarriga/nvim-notify", enabled = false },
  { "NMAC427/guess-indent.nvim", enabled = false },
  { "kevinhwang91/nvim-ufo", enabled = false },
}
