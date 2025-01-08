--- 来源: https://github.com/chaozwn/astronvim_user/blob/astro_v4/lua/plugins/auto-save.lua
--- 作用: 文件发生变动时自动保存

-- if true then return {} end

---@type LazySpec
return {
  "chaozwn/auto-save.nvim",
  event = { "InsertEnter" },
  opts = {
    debounce_delay = 3000,
    print_enabled = false,
    trigger_events = { "TextChanged" },
    condition = function(buf)
      local fn = vim.fn
      local utils = require "auto-save.utils.data"

      if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
        -- check weather not in normal mode
        if fn.mode() ~= "n" then
          return false
        else
          return true
        end
      end
      return false -- can't save
    end,
  },
  config = function(_, opts)
    local autoformat_group = vim.api.nvim_create_augroup("AutoformatToggle", { clear = true })
    require("auto-save").setup(opts)

    -- Disable autoformat before saving
    vim.api.nvim_create_autocmd("User", {
      group = autoformat_group,
      pattern = "AutoSaveWritePre",
      desc = "Disable autoformat before saving",
      callback = function()
        -- Save global autoformat status
        vim.g.OLD_AUTOFORMAT = vim.g.autoformat
        vim.g.autoformat = false

        local old_autoformat_buffers = {}
        -- Disable all manually enabled buffers
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.b[bufnr].autoformat then
            table.insert(old_autoformat_buffers, bufnr)
            vim.b[bufnr].autoformat = false
          end
        end

        vim.g.OLD_AUTOFORMAT_BUFFERS = old_autoformat_buffers
      end,
    })

    -- Re-enable autoformat after saving
    vim.api.nvim_create_autocmd("User", {
      group = autoformat_group,
      pattern = "AutoSaveWritePost",
      desc = "Re-enable autoformat after saving",
      callback = function()
        -- Restore global autoformat status
        vim.g.autoformat = vim.g.OLD_AUTOFORMAT
        -- Re-enable all manually enabled buffers
        for _, bufnr in ipairs(vim.g.OLD_AUTOFORMAT_BUFFERS or {}) do
          vim.b[bufnr].autoformat = true
        end
      end,
    })
  end,
}
