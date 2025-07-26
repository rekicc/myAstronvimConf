-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder

  --- 将当前聚焦的代码外的部分暗淡化
  -- { import = "astrocommunity.color.twilight-nvim" },
  { import = "astrocommunity.color.tint-nvim" },
  -- { import = "astrocommunity.color.transparent-nvim" },

  --- blink-cmp补全插件
  -- { import = "astrocommunity.completion.blink-cmp" },

  { import = "astrocommunity.keybinding.nvcheatsheet-nvim" },

  --- 支持.vscode/launch.json的json5语法
  { import = "astrocommunity.utility.lua-json5" },

  --- 关闭nvim-dap自动加载
  -- { import = "astrocommunity.utility.mason-tool-installer-nvim" },

  { import = "astrocommunity.pack.java" },
}
