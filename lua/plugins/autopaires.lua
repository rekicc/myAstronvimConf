---@type LazySpec
return {
  {
    "windwp/nvim-autopairs",
    optional = false,
    enabled = false,
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        map_c_h = true,
        map_c_w = true,
        map_bs = true,
        check_ts = true,
        enable_abbr = true,
        map_cr = false,
        enable_check_bracket_line = true,
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
    specs = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        ---@diagnostic disable: missing-fields
        ---@diagnostic disable: missing-parameter
        opts = function(_, opts)
          local maps = opts.mappings or {}
          maps.n["<Leader>ua"] = {
            function() vim.g.minipairs_disable = not vim.g.minipairs_disable end,
            desc = "Toggle mini pairs",
          }
        end,
      },
    },
    config = function(_, opts)
      local pairs = require "mini.pairs"
      pairs.setup(opts)
      local open = pairs.open
      pairs.open = function(pair, neigh_pattern)
        if vim.fn.getcmdline() ~= "" then return open(pair, neigh_pattern) end
        local o, c = pair:sub(1, 1), pair:sub(2, 2)
        local line = vim.api.nvim_get_current_line()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local next = line:sub(cursor[2] + 1, cursor[2] + 1)
        local before = line:sub(1, cursor[2])
        if opts.markdown and o == "`" and vim.bo.filetype == "markdown" and before:match "^%s*``" then
          return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
        end
        if opts.skip_next and next ~= "" and next:match(opts.skip_next) then return o end
        if opts.skip_ts and #opts.skip_ts > 0 then
          local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
          for _, capture in ipairs(ok and captures or {}) do
            if vim.tbl_contains(opts.skip_ts, capture.capture) then return o end
          end
        end
        if opts.skip_unbalanced and next == c and c ~= o then
          local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
          local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
          if count_close > count_open then return o end
        end
        return open(pair, neigh_pattern)
      end
      -- setup keymap
      local map_bs = function(lhs, rhs) vim.keymap.set("i", lhs, rhs, { expr = true, replace_keycodes = false }) end

      map_bs("<C-h>", "v:lua.MiniPairs.bs()")
      map_bs("<C-w>", 'v:lua.MiniPairs.bs("\23")')
      map_bs("<C-u>", 'v:lua.MiniPairs.bs("\21")')
    end,
  },
}
