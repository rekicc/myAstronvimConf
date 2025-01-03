--[[
--来源: https://github.com/Alexis12119/nvim-config/blob/main/lua/plugins/nvim-cmp.lua
--]]
if true then return {} end
return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    -- Commandline completions
    {
      "hrsh7th/cmp-cmdline",
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
  },

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
}
