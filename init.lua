-----------------------------------------------------------
--  Bootstrap Lazy.nvim
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
--  Lazy Plugin
-----------------------------------------------------------
require("lazy").setup({

  ---------------------------------------------------------
  -- Colorscheme
  ---------------------------------------------------------
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  },

  ---------------------------------------------------------
  -- Which-key (Keybind Hints)
  ---------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  ---------------------------------------------------------
  -- Neo-tree (File Explorer)
  ---------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
     opts ={
	filesystem = {
		filtered_items = {
		visible = true,
		show_hidden_count = true,
		hide_dotfiles = false,
		hide_gitignored = true,
		hide_by_name = {
			-- '.git',
			  '.DS_Store',
			-- 'thumbs.db', 
				},
			never_show = {},
			},
		}
	},
    config = function()
      require("neo-tree").setup({})
    end,
  },

  ---------------------------------------------------------
  -- Telescope (Fuzzy Finder)
  ---------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end,
  },

  ---------------------------------------------------------
  -- Treesitter (Syntax Highlighting)
  ---------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "bash", "python", "javascript", "html", "css", "json", "php", "blade" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  
---------------------------------------------------------
-- Autocompletion (VSCode-like)
---------------------------------------------------------
{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind-nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
      }),

      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
},

---------------------------------------------------------
-- Mason (Installer)
---------------------------------------------------------
{
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
  end,
},

---------------------------------------------------------
-- Mason LSP Config
---------------------------------------------------------
{
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "intelephense",
      -- fuh ass chatgpt doesnt know where to get the blade languange server  "blade_ls",      -- ✔ correct name for mason-lspconfig
      },
    })
  end,
},

---------------------------------------------------------
-- LSP Config (Neovim 0.11 style)
---------------------------------------------------------
{
  "neovim/nvim-lspconfig",
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local on_attach = function(_, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end

    -- PHP
    vim.lsp.config.intelephense = {
      cmd = { "intelephense", "--stdio" },
      filetypes = { "php" },
      root_markers = { "composer.json", ".git" },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        intelephense = {
          files = { maxSize = 5000000 },
        },
      },
    }
    vim.lsp.enable("intelephense")

    -- Laravel (Blade)
    vim.lsp.config.laravel = {
      cmd = { "laravel-dev-tools", "lsp" },
      filetypes = { "blade" },
      root_markers = { "composer.json", ".git" },
      capabilities = capabilities,
      on_attach = on_attach,
    }
    vim.lsp.enable("laravel")
  end,
},

---------------------------------------------------------
-- Laravel Support
---------------------------------------------------------
{
  "adibhanna/laravel.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  config = function()
    require("laravel").setup()
  end,
},

---------------------------------------------------------
-- Blade Syntax Highlighting
---------------------------------------------------------
{
  "jwalton512/vim-blade",
},
  ---------------------------------------------------------
  -- Treesitter Blade Grammar
  ---------------------------------------------------------
  {
    "EmranMR/tree-sitter-blade",
    config = function()
      require("nvim-treesitter.parsers").get_parser_configs().blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      require("nvim-treesitter.configs").setup({
        ensure_installed = { "blade" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "blade" },
        },
      })
    end,
  },
  ---------------------------------------------------------
  -- Nvim-autopairs
  ---------------------------------------------------------
  {
   "windwp/nvim-autopairs",
   event = "InsertEnter",
   config = function()
   require("nvim-autopairs").setup({})
   end,
   },

-----------------------------------------------------------
--- Autosave
-----------------------------------------------------------
      {
        '0x00-ketsu/autosave.nvim',
        event = { "InsertLeave", "TextChanged" },
        config = function()
          require('autosave').setup {
            -- Your configuration options for autosave.nvim go here.
            -- You can leave this empty to use the default settings.
            -- Example options:
            enabled = true, -- Enable/disable autosave globally
            trigger_events = { "InsertLeave", "TextChanged" }, -- Events that trigger autosave
            debounce_delay = 1000, -- Delay in milliseconds before saving after a change
            exclude_filetypes = { "gitcommit", "gitrebase" }, -- Filetypes to exclude from autosave
          }
        end,
      },

----------------------------------------------------------
--- Error debugging (show red, and error reason)
----------------------------------------------------------
{
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

  config = function()
    -- Enable inline diagnostic messages
    require("lsp_lines").setup()

    vim.diagnostic.config({
      virtual_text = false,   -- Disable old virtual text
      virtual_lines = true,   -- Show full inline message (ErrorLens)
      severity_sort = true,
    })

    -- Full-line highlight like VSCode ErrorLens
    vim.api.nvim_set_hl(0, "DiagnosticLineError", { bg = "#3c0000" })   -- dark red
    vim.api.nvim_set_hl(0, "DiagnosticLineWarn",  { bg = "#3c2f00" })   -- dark yellow
    vim.api.nvim_set_hl(0, "DiagnosticLineInfo",  { bg = "#1a2b3c" })
    vim.api.nvim_set_hl(0, "DiagnosticLineHint",  { bg = "#001f2f" })

    -- Automatically highlight the entire line with diagnostic colors
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      callback = function()
        -- clear existing highlights
        vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_create_namespace("errorlens"), 0, -1)

        local ns = vim.api.nvim_create_namespace("errorlens")
        local diagnostics = vim.diagnostic.get(0)

        for _, d in ipairs(diagnostics) do
          local line = d.lnum
          local severity = d.severity

          local group = ({
            [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
            [vim.diagnostic.severity.WARN]  = "DiagnosticLineWarn",
            [vim.diagnostic.severity.INFO]  = "DiagnosticLineInfo",
            [vim.diagnostic.severity.HINT]  = "DiagnosticLineHint",
          })[severity]

          -- Highlight entire line (0 to max col)
          vim.api.nvim_buf_add_highlight(
            0, ns, group, line, 0, -1
          )
        end
      end
    })
  end,
},

})

-----------------------------------------------------------
--  Keybinds
-----------------------------------------------------------

-- Leader key
vim.g.mapleader = " "

local map = vim.keymap.set

-----------------------------------------------------------
-- Neo-tree keybind
-----------------------------------------------------------
map("n", "<leader>fe", ":Neotree toggle<CR>", { desc = "Toggle File Explorer" })
map("n", "<leader>e", ":Neotree<CR>", {desc = "Open File Explorer"})

-----------------------------------------------------------
-- Telescope keybinds
-----------------------------------------------------------
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-----------------------------------------------------------
-- Quality of Life
-----------------------------------------------------------
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>w", ":w<CR>", { desc = "Save" })

-----------------------------------------------------------
-- Clipboard copy/paste
-----------------------------------------------------------
vim.opt.clipboard = "unnamedplus"  -- use system clipboard

-----------------------------------------------------------
-- UI Tweaks
-----------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
