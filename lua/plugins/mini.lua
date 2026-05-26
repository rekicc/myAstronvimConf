-- if true then return {} end
--mini.nvim,一系列的提升体验的插件列表,可以按需开启
return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      -- =========================================================================
      -- 1. 在这里初始化 mini.nvim 的其他子模块（根据你的需要取消注释或添加）
      -- =========================================================================
      -- require("mini.animate").setup()
      require("mini.icons").setup()
      require("mini.surround").setup()
      -- require("mini.ai").setup()
      -- require("mini.jump").setup()
      -- require("mini.sessions").setup()

      -- =========================================================================
      -- 2. 整合你原本的高级 mini.pairs 配置
      -- =========================================================================
      -- 将原本外部的 opts 变量提取到本地，供接下来的逻辑使用
      local pairs_opts = {
        modes = { insert = true, command = true, terminal = false },
        skip_next = [=[[%w%%%'%[%"%.%`%\$]]=],
        skip_ts = { "string" },
        skip_unbalanced = true,
        markdown = true,
      }

      local pairs = require "mini.pairs"
      pairs.setup(pairs_opts)

      -- =========================================================================
      -- LISP / RACKET 特殊适配：禁止在 Racket 和 Lisp 语言中自动配对单引号和反引号
      -- =========================================================================
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "racket", "lisp", "scheme", "clojure", "fennel" },
        callback = function()
          -- 利用 Buffer 本地映射（优先级最高），强行将按键恢复为原生单字输出，直接绕过插件
          vim.keymap.set("i", "'", "'", { buffer = true, nowait = true })
          vim.keymap.set("i", "`", "`", { buffer = true, nowait = true })
        end,
      })
      -- =========================================================================

      -- 拦截并重写原厂的 pairs.open 函数，注入你的高级过滤逻辑
      local open = pairs.open
      pairs.open = function(pair, neigh_pattern)
        if vim.fn.getcmdline() ~= "" then return open(pair, neigh_pattern) end
        local o, c = pair:sub(1, 1), pair:sub(2, 2)
        local line = vim.api.nvim_get_current_line()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local next = line:sub(cursor[2] + 1, cursor[2] + 1)
        local before = line:sub(1, cursor[2])

        -- Markdown 3-backticks 智能处理
        if pairs_opts.markdown and o == "`" and vim.bo.filetype == "markdown" and before:match "^%s*``" then
          return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
        end

        -- 检查右侧拦截字符 (skip_next)
        if pairs_opts.skip_next and next ~= "" and next:match(pairs_opts.skip_next) then return o end

        -- 检查 Treesitter 语法节点 (skip_ts)
        if pairs_opts.skip_ts and #pairs_opts.skip_ts > 0 then
          local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
          for _, capture in ipairs(ok and captures or {}) do
            if vim.tbl_contains(pairs_opts.skip_ts, capture.capture) then return o end
          end
        end

        -- 检查右侧非对称括号 (skip_unbalanced)
        if pairs_opts.skip_unbalanced and vim.bo.filetype ~= "racket" and next == c and c ~= o then
          local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
          local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
          if count_close > count_open then return o end
        end

        return open(pair, neigh_pattern)
      end

      -- 智能删除快捷键绑定（删除左括号同步删除右括号）
      local map_bs = function(lhs, rhs) vim.keymap.set("i", lhs, rhs, { expr = true, replace_keycodes = false }) end
      map_bs("<C-h>", "v:lua.MiniPairs.bs()")
      map_bs("<C-w>", 'v:lua.MiniPairs.bs("\23")')
      map_bs("<C-u>", 'v:lua.MiniPairs.bs("\21")')
    end,

    -- =========================================================================
    -- 3. 保留你原有的 AstroNvim 开关逻辑
    -- =========================================================================
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
  },
}
