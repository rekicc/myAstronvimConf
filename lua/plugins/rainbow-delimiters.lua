--- 来源: https://github.com/chaozwn/astronvim_user/blob/astro_v4/lua/plugins/rainbow-delimiters.lua
--- 作用: 美化成对的括号

-- if true then return {} end

---@type LazySpec
return {
  "HiPhish/rainbow-delimiters.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = "User AstroFile",
  main = "rainbow-delimiters.setup",
}
