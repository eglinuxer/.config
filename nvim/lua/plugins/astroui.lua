-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "astrodark",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
        
        -- tpipeline Nord-compatible highlights (fallback if Nord theme not available)
        NordBlue      = { fg = "#88C0D0", bg = "#3B4252" },
        NordCyan      = { fg = "#8FBCBB", bg = "#434C5E" },
        NordYellow    = { fg = "#EBCB8B", bg = "#434C5E" },
        NordOrange    = { fg = "#D08770", bg = "#434C5E" },
        NordFrost     = { fg = "#81A1C1", bg = "#434C5E" },
        NordSnow3     = { fg = "#ECEFF4", bg = "#434C5E" },
        NordDarkGray  = { fg = "#434C5E", bg = "#3B4252" },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
        
        -- Make astrodark more Nord-compatible for tpipeline
        StatusLine   = { bg = "#3B4252", fg = "#D8DEE9" },
        StatusLineNC = { bg = "#2E3440", fg = "#616E88" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
