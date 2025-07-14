-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "cmake", -- CMake syntax highlighting
      "python", -- Python syntax highlighting
      "cpp", -- C++ syntax highlighting
      "c", -- C syntax highlighting
      "bash", -- Bash syntax highlighting
      "json", -- JSON syntax highlighting
      "markdown", -- Markdown syntax highlighting
      -- add more arguments for adding more treesitter parsers
    },
  },
}
