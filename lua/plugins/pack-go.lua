--- 来源：https://github.com/chaozwn/astronvim_user/blob/astro_v4/lua/plugins/pack-go.lua

if true then return {} end

--TODO: https://github.com/golang/go/issues/60903
local function preview_stack_trace()
  local current_line = vim.api.nvim_get_current_line()
  local patterns_list = {
    "([^%s]+/[^%s]+%.go):(%d+)", -- 匹配文件路径和行号
  }

  local function try_patterns(patterns, line)
    for _, pattern in ipairs(patterns) do
      local filepath, line_nr = string.match(line, pattern)
      if filepath and line_nr then return filepath, tonumber(line_nr), 0 end
    end
    return nil, nil, nil
  end

  local filepath, line_nr, column_nr = try_patterns(patterns_list, current_line)
  if filepath then
    vim.cmd ":wincmd k"
    vim.cmd("e " .. filepath)
    vim.api.nvim_win_set_cursor(0, { line_nr, column_nr })
  end
end

-- NOTE: gopls commands
-- GoTagAdd add tags
-- GOTagRm remove tags
-- GoCmt add cmt
-- GoFillStruct	auto fill struct
-- GoFillSwitch	fill switch
-- GoIfErr	Add if err
-- GoFixPlurals	change func foo(b int, a int, r int) -> func foo(b, a, r int)

---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = { filetypes = { extension = { api = "goctl" } } },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        config = {
          gopls = {
            on_attach = function(client, _)
              vim.api.nvim_create_autocmd({ "TermOpen", "TermClose", "BufEnter" }, {
                pattern = "*",
                desc = "Jump to error line",
                callback = function()
                  local buf_name = vim.api.nvim_buf_get_name(0)
                  if vim.bo.filetype == "dap-repl" and buf_name:match "%[dap%-repl%-%d+%]" then
                    require("astrocore").set_mappings({
                      n = {
                        ["gd"] = {
                          preview_stack_trace,
                          desc = "Jump to error line",
                        },
                      },
                    }, { buffer = true })
                  end
                end,
              })

              if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end,
            settings = {
              gopls = {
                analyses = {
                  ST1003 = false,
                  SA5008 = false,
                  fieldalignment = false,
                  fillreturns = true,
                  nilness = true,
                  nonewvars = true,
                  shadow = true,
                  undeclaredname = true,
                  unreachable = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                codelenses = {
                  gc_details = false, -- Show a code lens toggling the display of gc's choices.
                  generate = true, -- show the `go generate` lens.
                  regenerate_cgo = true,
                  test = true,
                  tidy = true,
                  upgrade_dependency = true,
                  vendor = true,
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
                completeUnimported = true,
                diagnosticsDelay = "500ms",
                gofumpt = true,
                matcher = "Fuzzy",
                semanticTokens = true,
                staticcheck = true,
                symbolMatcher = "fuzzy",
                usePlaceholders = false,
              },
            },
          },
        },
      })
    end,
  },
  -- Golang support
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed =
          require("astrocore").list_insert_unique(opts.ensure_installed, { "go", "gomod", "gosum", "gowork", "goctl" })
      end
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      if vim.fn.executable "go" == 1 then
        opts.ensure_installed = require("astrocore").list_insert_unique(
          opts.ensure_installed,
          { "delve", "gopls", "gomodifytags", "gotests", "iferr", "impl", "goimports" }
        )
      end
    end,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      {
        "Snikimonkd/cmp-go-pkgs",
        ft = "go",
        enabled = vim.fn.executable "go" == 1,
      },
    },
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        sources = {
          compat = require("astrocore").list_insert_unique(opts.sources.compat or {}, { "go_pkgs" }),
          providers = {
            go_pkgs = {
              kind = "Gopkgs",
              score_offset = 100,
              async = true,
              enabled = function()
                return vim.fn.executable "go" == 1 and require("cmp_go_pkgs")._check_if_inside_imports()
              end,
            },
          },
        },
      })
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    enabled = vim.fn.executable "go" == 1,
    build = function()
      if not require("lazy.core.config").spec.plugins["mason.nvim"] then
        vim.print "Installing go dependencies..."
        vim.cmd.GoInstallDeps()
      end
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "williamboman/mason.nvim", optional = true }, -- by default use Mason for go dependencies
    },
    opts = {},
  },
  {
    "nvim-neotest/neotest-go",
    ft = "go",
    enabled = vim.fn.executable "go" == 1,
    dependencies = {
      {
        "nvim-neotest/neotest",
        optional = true,
        opts = function(_, opts)
          if not opts.adapters then opts.adapters = {} end
          table.insert(opts.adapters, require "neotest-go"(require("astrocore").plugin_opts "neotest-go"))
        end,
      },
    },
  },
  {
    "chaozwn/goctl.nvim",
    ft = "goctl",
    enabled = vim.fn.executable "goctl" == 1,
    opts = function()
      local group = vim.api.nvim_create_augroup("GoctlAutocmd", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "goctl",
        callback = function()
          -- set up format keymap
          vim.keymap.set(
            "n",
            "<Leader>lf",
            "<Cmd>GoctlApiFormat<CR>",
            { silent = true, noremap = true, buffer = true, desc = "Format Buffer" }
          )
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", lsp_format = "last" },
      },
    },
  },
  {
    "echasnovski/mini.icons",
    optional = true,
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
      },
    },
  },
  -- go all in one
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      run_in_floaterm = true,
      --因为go.nvim内置了nvim-dap-ui的支持,所以在nvim-dap-ui其自身中设置布局是无用的,必须通过go.nvim自身的变量来改变布局
      dap_debug_gui = {
        layouts = {
          {
            elements = {
              { id = "breakpoints", size = 0.25 },
              { id = "watches", size = 0.2 },
              { id = "stacks", size = 0.2 },
              { id = "scopes", size = 0.4 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.95 },
            },
            position = "bottom",
            size = 10,
          },
        },
      },
      --icons = { breakpoint = "", currentpos = "🏃"},
      icons = false,
      --设置为false后侧边栏提示错误和警告的标志使用NvChad提供的,比较美观
      diagnostic = false,
    },
    --event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
