--- 来源：https://github.com/chaozwn/astronvim_user/blob/astro_v4/lua/plugins/motlen.lua
--- 作用：交互式运行代码

-- if true then return {} end

return {
  "benlubas/molten-nvim",
  lazy = true,
  version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
  build = ":UpdateRemotePlugins",
  init = function()
    -- this is an example, not a default. Please see the readme for more configuration options
  end,
  specs = {
    { "AstroNvim/astroui", opts = { icons = { Molten = "󱓞" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings or {}
        local prefix = "<leader>j"

        maps.n[prefix] = { desc = require("astroui").get_icon("Molten", 1, true) .. "Molten" }
        maps.n[prefix .. "e"] = { "<Cmd>MoltenEvaluateOperator<CR>", desc = "Run operator selection" }
        maps.n[prefix .. "l"] = { "<Cmd>MoltenEvaluateLine<CR>", desc = "Evaluate line" }
        maps.n[prefix .. "c"] = { "<Cmd>MoltenReevaluateCell<CR>", desc = "Re-evaluate cell" }
        maps.n[prefix .. "k"] = { ":noautocmd MoltenEnterOutput<CR>", desc = "Enter Output" }
        maps.v[prefix .. "k"] = {
          function()
            vim.cmd "noautocmd MoltenEnterOutput"
            if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "\22" then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end,
          desc = "Enter Output",
        }

        maps.n[prefix .. "m"] = { desc = "Commands" }
        maps.n[prefix .. "mi"] = { "<Cmd>MoltenInit<CR>", desc = "Initialize the plugin" }
        maps.n[prefix .. "mh"] = { "<Cmd>MoltenHideOutput<CR>", desc = "Hide Output" }
        maps.n[prefix .. "mI"] = { "<Cmd>MoltenInterrupt<CR>", desc = "Interrupt Kernel" }
        maps.n[prefix .. "mR"] = { "<Cmd>MoltenRestart<CR>", desc = "Restart Kernel" }

        maps.v[prefix] = { desc = require("astroui").get_icon("Molten", 1, true) .. "Molten" }
        maps.v[prefix .. "r"] = { ":<C-u>MoltenEvaluateVisual<CR>", desc = "Evaluate visual selection" }

        maps.n["]c"] = { "<Cmd>MoltenNext<CR>", desc = "Next Molten Cel" }
        maps.n["[c"] = { "<Cmd>MoltenPrev<CR>", desc = "Previous Molten Cell" }

        opts.options.g["molten_auto_image_popup"] = false
        opts.options.g["molten_auto_open_html_in_browser"] = false
        opts.options.g["molten_auto_open_output"] = false
        opts.options.g["molten_cover_empty_lines"] = true

        opts.options.g["molten_enter_output_behavior"] = "open_and_enter"
        -- molten_output

        opts.options.g["molten_image_location"] = "both"
        opts.options.g["molten_image_provider"] = "image.nvim"
        opts.options.g["molten_output_show_more"] = true
        opts.options.g["molten_use_border_highlights"] = true

        opts.options.g["molten_output_virt_lines"] = false
        opts.options.g["molten_virt_lines_off_by_1"] = false
        opts.options.g["molten_virt_text_output"] = false
        opts.options.g["molten_wrap_output"] = true

        return opts
      end,
    },
  },
}
