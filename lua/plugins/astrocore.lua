-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  -- version = false,
  -- branch = "v2",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = false, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic  setting on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = { prefix = "" },
      underline = true,
      update_in_insert = false,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        fillchars = {
          fold = " ",
          foldsep = " ",
          foldopen = "",
          foldclose = "",
          diff = "╱",
          eob = " ",
        },
        conceallevel = 2,
        list = false,
        listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
        showbreak = "↪ ",
        splitkeep = "screen",
        swapfile = false,
        scrolloff = 5,
        -- windows
        winwidth = 10,
        winminwidth = 10,
        equalalways = false,
        smoothscroll = true,
        -- foldexpr = "v:lua.require'ui'.foldexpr()",
        foldexpr = "v:lua.require'utils'.foldexpr()",
        foldmethod = "expr",
        foldtext = "",
        -- foldlevel = 99,
        statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]],
        showcmdloc = "statusline",
        shiftwidth = 4,
        tabstop = 4,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        autoformat = false,
        -- trouble_lualine = true,
      },
      o = {
        laststatus = 3,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
    autocmds = {
      auto_turnoff_paste = {
        {
          event = "InsertLeave",
          pattern = "*",
          command = "set nopaste",
        },
      },
      auto_close_molten_output = {
        {
          event = "FileType",
          pattern = { "molten_output" },
          callback = function(event)
            vim.bo[event.buf].buflisted = false
            vim.schedule(function()
              vim.keymap.set("n", "q", function() vim.cmd "MoltenHideOutput" end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
              })
            end)
          end,
        },
      },
    },
  },
}
