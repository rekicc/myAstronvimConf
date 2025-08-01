--- 来源: https://github.com/chaozwn/astronvim_user/blob/astro_v4/lua/plugins/visual-multi.lua
--- 作用: 虚拟多光标

if true then return {} end

---@type LazySpec
return {
  "mg979/vim-visual-multi",
  event = "BufEnter",
  specs = {
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts, {
          options = {
            g = {
              ["VM_default_mappings"] = 0,
              ["Find Under"] = "<C-n>",
              ["Find Subword Under"] = "<C-n>",
              ["Add Cursor Up"] = "<C-S-k>",
              ["Add Cursor Down"] = "<C-S-j>",
              ["Select All"] = "<C-S-n>",
              ["Skip Region"] = "<C-x>",
            },
          },
        })
      end,
    },
  },
}
