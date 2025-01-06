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
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  { "rcarriga/nvim-notify", enabled = false },
  { "NMAC427/guess-indent.nvim", enabled = false },
}
