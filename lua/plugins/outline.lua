--outline,设置拷贝自LazyVim->Extras->editor->outline下的配置文件,进行了本地适配性改动
return {
  "hedyhli/outline.nvim",
  keys = { { "<leader>to", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
  cmd = "Outline",
  opts = function()
    local defaults = require("outline.config").defaults
    --LazyVim下的配置引用了它的项目中的变量,因为没有使用LazyVim,只能把该变量完全拷到本地使用,注释掉的Icon保留了outline的默认配置
    local kinds = {
      Array = " ",
      Boolean = "󰨙 ",
      Class = " ",
      Codeium = "󰘦 ",
      Color = " ",
      Control = " ",
      Collapsed = " ",
      Constant = "󰏿 ",
      --Constructor = " ",
      Copilot = " ",
      --Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = "󰊕 ",
      Interface = " ",
      Key = " ",
      Keyword = " ",
      Method = "ƒ ",
      Module = " ",
      Namespace = "󰦮 ",
      Null = " ",
      Number = "󰎠 ",
      Object = " ",
      Operator = " ",
      --Package = " ",
      --Property = " ",
      Reference = " ",
      Snippet = " ",
      String = " ",
      Struct = "󰆼 ",
      Supermaven = " ",
      TabNine = "󰏚 ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = "󰀫 ",
    }

    local opts = {
      symbols = {
        icons = {},
      },
    }
    for kind, symbol in pairs(defaults.symbols.icons) do
      opts.symbols.icons[kind] = {
        icon = kinds[kind] or symbol.icon,
        hl = symbol.hl,
      }
    end
    return opts
  end,
}
