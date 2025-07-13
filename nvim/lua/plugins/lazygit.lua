-- LazyGit integration for AstroNvim
-- Provides a terminal UI for Git operations

---@type LazySpec
return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<Leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
}
