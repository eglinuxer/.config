-- tpipeline setup and troubleshooting utilities
-- Run :TpipelineStatus to check configuration

---@type LazySpec
return {
  "vimpostor/vim-tpipeline",
  dependencies = { "AstroNvim/astroui" },
  cmd = { "TpipelineStatus", "TpipelineToggle", "TpipelineRestart" },
  config = function()
    -- User commands for managing tpipeline
    vim.api.nvim_create_user_command("TpipelineStatus", function()
      print("=== vim-tpipeline Status ===")
      print("TMUX detected: " .. (vim.env.TMUX and "✓" or "✗"))
      print("tpipeline loaded: " .. (vim.g.loaded_tpipeline and "✓" or "✗"))
      print("Focus events: " .. (vim.o.focusevents and "✓" or "✗"))
      
      if vim.env.TMUX then
        print("\n=== Current tmux settings ===")
        vim.fn.system("tmux show-options -g focus-events")
        vim.fn.system("tmux show-options -g status-left-length")
        vim.fn.system("tmux show-options -g status-right-length")
      else
        print("\nNot running inside tmux - tpipeline will not function")
      end
    end, { desc = "Show tpipeline status and configuration" })
    
    vim.api.nvim_create_user_command("TpipelineToggle", function()
      if vim.g.tpipeline_restore then
        vim.g.tpipeline_restore = 0
        print("tpipeline disabled")
      else
        vim.g.tpipeline_restore = 1
        print("tpipeline enabled")
      end
    end, { desc = "Toggle tpipeline on/off" })
    
    vim.api.nvim_create_user_command("TpipelineRestart", function()
      if vim.env.TMUX then
        vim.fn.system("tmux source-file ~/.config/tmux/tmux.conf")
        print("Reloaded tmux configuration")
        -- Trigger statusline update
        vim.cmd("redrawstatus!")
      else
        print("Not in tmux session")
      end
    end, { desc = "Restart tpipeline by reloading tmux config" })
  end,
}