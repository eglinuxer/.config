-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = {
        prefix = "●", -- change diagnostic symbols
        spacing = 2,
        severity = { min = vim.diagnostic.severity.HINT }, -- show all severities
      },
      underline = true,
      signs = true, -- show signs in sign column
      severity_sort = true, -- sort by severity
      float = {
        border = "rounded", -- rounded border for diagnostic floats
        source = true, -- show source of diagnostic
        header = "",
        prefix = "",
      },
      update_in_insert = false, -- don't update diagnostics in insert mode
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = true, -- sets vim.opt.wrap
        cmdheight = 2, -- increase command line height to avoid copy prompts
        clipboard = "unnamedplus", -- use system clipboard
        -- default indentation settings
        tabstop = 2, -- display width of tab character
        shiftwidth = 2, -- auto-indent width
        softtabstop = 2, -- tab width in insert mode
        expandtab = true, -- use spaces instead of tabs
        smartindent = true, -- smart indentation
        autoindent = true, -- auto indentation
        -- invisible characters display
        list = true, -- enable list mode to show invisible characters
        listchars = {
          space = "·", -- show spaces as dots
          tab = "→ ", -- show tabs as arrows
          eol = "↵", -- show line endings
          trail = "●", -- show trailing spaces as bullets
          extends = "»", -- show line extends off screen
          precedes = "«", -- show line precedes off screen
          nbsp = "×", -- show non-breaking spaces
        },
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- autocmd configuration
    autocmds = {
      -- language-specific indentation settings
      indent_settings = {
        {
          event = "FileType",
          pattern = { "python" },
          callback = function()
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
            vim.opt_local.softtabstop = 4
          end,
        },
        {
          event = "FileType",
          pattern = { "c", "cpp", "h", "hpp" },
          callback = function()
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
            vim.opt_local.softtabstop = 4
          end,
        },
        {
          event = "FileType",
          pattern = { "sh", "bash", "zsh" },
          callback = function()
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
            vim.opt_local.softtabstop = 4
          end,
        },
        {
          event = "FileType",
          pattern = { "cmake" },
          callback = function()
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
            vim.opt_local.softtabstop = 4
          end,
        },
        {
          event = "FileType",
          pattern = { "make", "makefile" },
          callback = function()
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
            vim.opt_local.softtabstop = 4
            vim.opt_local.expandtab = false
          end,
        },
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- Additional LazyGit mappings (main mappings are in lazygit.lua)
        ["<Leader>gg"] = { "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
        ["<Leader>gc"] = { "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },

        -- Toggle invisible characters
        ["<Leader>ui"] = { "<cmd>set list!<cr>", desc = "Toggle invisible characters" },

        -- Diagnostic navigation
        ["]d"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
        ["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
        ["<Leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Show line diagnostics" },
        ["<Leader>lD"] = { function() vim.diagnostic.setloclist() end, desc = "Show diagnostics list" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
