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
      debug = { enabled = true },
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
        maps.n["<Leader>fk"] = {
          function() sn.picker.keymaps() end,
          desc = "find keymaps",
        }
      end,
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  { "rcarriga/nvim-notify", enabled = false },
  { "NMAC427/guess-indent.nvim", enabled = false },
  { "kevinhwang91/nvim-ufo", enabled = false },
}
