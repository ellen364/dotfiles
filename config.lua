--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.backspace = "indent,eol,start"  -- make backspace work properly
vim.opt.clipboard:append("unnamedplus") -- use standard clipboard
vim.opt.iskeyword:append("-")           -- treat - as part of words, e.g. str-str gets entirely deleted

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["x"] = "_x"     -- when delete character using x, don't copy it into the register / clipboard
lvim.keys.insert_mode["jk"] = "<ESC>" -- in insert mode, jk equivalent to Esc (returns to normal mode)
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["+"] = { "<C-a>", "Increment number under cursor" }
lvim.builtin.which_key.mappings["-"] = { "<C-x>", "Decrement number under cursor" }
lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  b = { "<cmd>Telescope buffers previewer=false<cr>", "Find Buffer" },
  c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
  f = { "<cmd>Telescope find_files<cr>", "Find File" },
  h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
  H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
  M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  R = { "<cmd>Telescope registers<cr>", "Registers" },
  t = { "<cmd>Telescope live_grep<cr>", "Text" },
  k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  C = { "<cmd>Telescope commands<cr>", "Commands" },
  l = { "<cmd>Telescope resume<cr>", "Resume last search" },
  p = {
    "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
    "Colorscheme with Preview",
  },
}

lvim.builtin.which_key.mappings["s"] = {
  name = "Split window",
  v = { "<C-w>v", "Vertical split" },
  h = { "<C-w>s", "Horizontal split" },
  x = { ":close<CR>", "Close current split" },
  e = { "<C-w>=", "Make splits equal width & height" },
}

-- -- Change theme settings
lvim.colorscheme = "onedark"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  { "navarasu/onedark.nvim" },
  { "olimorris/onedarkpro.nvim" },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    -- tag = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {  -- Adds pretty icons to your documents
            config = {
              icons = {
                todo = {
                  undone = {
                    icon = " ",
                  },
                },
              },
            },
          },
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/Documents/notes",
              },
            },
          },
          ["core.journal"] = {
            config = {
              strategy = "flat",
            },
          },
        },
      }
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
