-- if true then return {} end

local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },

    ---[[来源: https://www.bilibili.com/video/BV1g14y1o7Qq?vd_source=36cd4c6a90b219eed5c943bcbd0f2eda&spm_id_from=333.788.videopod.sections
    ---  目的: 更改nvim-cmp补全键位设置,tab直接补全,不再使用<CR>确认
    ---]]

    opts = function(_, opts)
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      return require("astrocore").extend_tbl(opts, {
        completeopt = "menu, menuone, noinsert",
        mapping = {
          ["<CR>"] = cmp.config.disable,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if not entry then
                cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
              else
                if has_words_before() then
                  cmp.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                  }
                else
                  cmp.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = false,
                  }
                end
              end
            else
              fallback()
            end
          end, { "i", "s" }),

          ---[[来源: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
          ---  目的: 使用<C-N>和<C-P>在cmp补全出来的luasnip片段的参数位置进行前后跳转
          ---]]

          ["<C-N>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-P>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
      })
    end,

    ---[[来源: https://github.com/Alexis12119/nvim-config/blob/main/lua/plugins/nvim-cmp.lua
    ---  目的: NvChad@2.5中添加codeium补全源
    ---  现状: 迁移到astronvim后实际已无需以下设置
    ---]]
    -- opts = function(_, opts)
    --NOTE: add border for cmp window

    -- if vim.g.border_enabled then
    --   opts.window = {
    --     completion = require("cmp").config.window.bordered(),
    --     documentation = require("cmp").config.window.bordered(),
    --   }
    -- end

    -- table.insert(opts.sources, 2, { name = "codeium" })
    -- table.insert(opts.sources, 1, { name = "supermaven" })

    -- -- cmp补全的来源
    -- opts.sources = {
    --   { name = "nvim_lsp" },
    --   -- { name = "codeium" },
    --   { name = "buffer" },
    --   { name = "nvim_lua" },
    --   { name = "path" },
    --   { name = "luasnip" },
    -- }
    -- opts.mapping = vim.tbl_extend("force", {}, opts.mapping, {
    --   -- You can add here new mappings.
    -- })
    --
    -- -- opts.completion["completeopt"] = "menu,menuone,noselect" -- disable autoselect
    --
    -- --是否自动开启补全,设为true则自动开启,下面的设置则是需要手动快捷键开启
    -- opts.enabled = true
    -- opts.enabled = function()
    --   return (vim.g.toggle_cmp and vim.bo.buftype == "")
    -- end

    -- 原作者加载的luasnip补全代码.用不上
    -- require("luasnip").filetype_extend("javascriptreact", { "html" })
    -- require("luasnip").filetype_extend("typescriptreact", { "html" })
    -- require("luasnip").filetype_extend("svelte", { "html" })
    -- require("luasnip").filetype_extend("vue", { "html" })
    -- require("luasnip").filetype_extend("php", { "html" })
    -- require("luasnip").filetype_extend("javascript", { "javascriptreact" })
    -- require("luasnip").filetype_extend("typescript", { "typescriptreact" })
    -- end,

    -- dependencies = {
    -- AI Autocomplete
    -- codeium
    -- { "Exafunction/codeium.nvim" },
    -- supermaven
    -- {
    --   "supermaven-inc/supermaven-nvim",
    --   -- commit = "df3ecf7",
    --   -- commit = "40bde487fe31723cdd180843b182f70c6a991226",
    --   event = "BufReadPost",
    --   opts = {
    --     disable_keymaps = false,
    --     disable_inline_completion = false,
    --     keymaps = {
    --       accept_suggestion = "<A-f>",
    --       clear_suggestion = "<Nop>",
    --       accept_word = "<A-w>",
    --     },
    --   },
    -- },
    --
    -- -- For Rust
    -- {
    --   "saecki/crates.nvim",
    --   tag = "v0.4.0",
    --   opts = {},
    -- },
    -- },
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    config = function()
      local cmdline_mappings = vim.tbl_extend("force", {}, require("cmp").mapping.preset.cmdline(), {
        -- ["<CR>"] = { c = require("cmp").mapping.confirm { select = true } },
      })

      require("cmp").setup.cmdline(":", {
        mapping = cmdline_mappings,
        sources = {
          { name = "cmdline" },
        },
      })
    end,
  },
}
