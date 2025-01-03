--- astrocommunity.completion.blink-cmp的自定义配置

if true then return {} end
local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        ["<CR>"] = { "fallback" },
        ["<C-N>"] = { "snippet_forward" },
        ["<C-P>"] = { "snippet_backward" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.accept()
            elseif has_words_before() then
              return cmp.show()
            end
          end,
        },
      },
    },
  },
}
