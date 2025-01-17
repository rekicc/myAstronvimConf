--- 来源: https://github.com/chaozwn/astronvim_user/blob/astro_v4/lua/plugins/flatten.lua
--- 作用: 将nvim terminal中通过nvim命令打开的文件直接显示到当前buffer中

-- if true then return {} end

---@type LazySpec
return {
  "willothy/flatten.nvim",
  opts = { window = { open = "alternate" } },
  lazy = true,
}
