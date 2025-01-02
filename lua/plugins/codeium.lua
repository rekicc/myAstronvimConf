return {
  "Exafunction/codeium.nvim",
  cmd = "Codeium",
  build = ":Codeium Auth",
  enabled = false,
  opts = {
    config_path = "/Users/reki/.config/codeium/apikey",
    bin_path = "/Users/reki/.config/codeium/bin",
    enable_cmp_source = true,
    -- virtual_text = {
    --   enabled = not vim.g.ai_cmp,
    --   key_bindings = {
    --     accept = false, -- handled by nvim-cmp / blink.cmp
    --     next = "<M-]>",
    --     prev = "<M-[>",
    --   },
    -- },
  },
}
