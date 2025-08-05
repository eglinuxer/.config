-- vim-tpipeline: Neovim statusline in tmux
-- Optimized for Nord theme integration and performance

---@type LazySpec
return {
  "vimpostor/vim-tpipeline",
  event = "VimEnter", -- Load when nvim starts
  cond = function()
    -- Only load if we're inside tmux
    return vim.env.TMUX ~= nil
  end,
  config = function()
    -- Performance settings
    vim.g.tpipeline_cursormoved = 1    -- Update on cursor movement
    vim.g.tpipeline_focuslost = 1      -- Update when focus is lost
    vim.g.tpipeline_restore = 1        -- Restore tmux statusline on exit
    vim.g.tpipeline_size = 1           -- Single line statusline
    vim.g.tpipeline_fillcentre = 0     -- Don't fill center (performance)
    
    -- Nord-compatible statusline format
    -- Using Nord color palette for consistency with tmux theme
    vim.g.tpipeline_statusline = table.concat({
      -- Left side: Mode and file info
      '%#NordBlue#', ' %{toupper(mode())} ',                    -- Mode in blue
      '%#NordDarkGray#%#NordCyan#',                            -- Separator
      '%#NordCyan#', ' %{expand("%:t")} ',                      -- Filename in cyan
      '%#NordYellow#', '%{&modified ? "● " : ""}',              -- Modified indicator
      '%#NordOrange#', '%{&readonly ? " " : ""}',             -- Readonly indicator
      
      -- Center: Git branch (if available)
      '%=',  -- Center alignment
      '%#NordFrost#', 
      '%{exists("*FugitiveHead") ? (FugitiveHead() != "" ? " ".FugitiveHead()." " : "") : ""}',
      
      -- Right side: File info and position
      '%=',  -- Right alignment
      '%#NordSnow3#', ' %{&filetype} ',                         -- File type
      '%#NordFrost#', ' %{&fileencoding?&fileencoding:&encoding} ', -- Encoding
      '%#NordBlue#', ' %c:%l/%L ',                              -- Position
      '%#NordCyan#', ' %p%% ',                                  -- Percentage
    }, '')
    
    -- Alternative simpler statusline for better performance
    -- Uncomment this and comment above for minimal version
    -- vim.g.tpipeline_statusline = 
    --   '%#NordBlue# %{mode()} %#NordCyan# %f %{&modified?"●":""}' ..
    --   '%=%#NordSnow3# %{&ft} %#NordBlue# %c:%l %#NordCyan# %p%% '
    
  end,
  init = function()
    -- Define Nord color highlights for statusline
    -- These will be available once colorscheme is loaded
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        -- Nord color definitions for statusline
        local nord_colors = {
          NordBlue      = { fg = "#88C0D0", bg = "#3B4252" },  -- Frost blue
          NordCyan      = { fg = "#8FBCBB", bg = "#434C5E" },  -- Frost cyan
          NordYellow    = { fg = "#EBCB8B", bg = "#434C5E" },  -- Aurora yellow
          NordOrange    = { fg = "#D08770", bg = "#434C5E" },  -- Aurora orange
          NordFrost     = { fg = "#81A1C1", bg = "#434C5E" },  -- Frost
          NordSnow3     = { fg = "#ECEFF4", bg = "#434C5E" },  -- Snow Storm
          NordDarkGray  = { fg = "#434C5E", bg = "#3B4252" },  -- Polar Night
        }
        
        for name, colors in pairs(nord_colors) do
          vim.api.nvim_set_hl(0, name, colors)
        end
      end,
    })
  end,
}