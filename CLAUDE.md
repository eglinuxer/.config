# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is **eglinux's cross-platform configuration repository** containing dotfiles and configurations for development tools. The repository manages configurations for:

- **Neovim**: AstroNvim v5+ based configuration with extensive plugin ecosystem
- **Tmux**: Terminal multiplexer with comprehensive plugin setup via TPM
- **Development Environment**: Docker container definition for consistent development environment

## Architecture and Structure

### Neovim Configuration (`nvim/`)
- **Framework**: AstroNvim v5+ template with Lazy.nvim plugin manager
- **Entry Point**: `init.lua` → `lazy_setup.lua` → individual plugin configurations
- **Plugin Structure**: 
  - `lua/plugins/` - Individual plugin configurations (astrocore.lua, astrolsp.lua, etc.)
  - `lua/community.lua` - Community plugin imports
  - `lua/polish.lua` - Final configuration tweaks
- **Key Features**: LSP integration, TreeSitter, Mason tool management, LazyGit integration

### Tmux Configuration (`tmux/`)
- **Plugin Manager**: TPM (Tmux Plugin Manager) with 15+ plugins
- **Main Config**: `tmux.conf` with custom prefix (C-a), vi-mode keys, mouse support
- **Key Plugins**: tmux-resurrect, tmux-continuum, tmux-sidebar, tmux-jump, various UI enhancements
- **Plugin Directory**: `plugins/` contains all tmux plugins as git submodules

### Development Environment (`dockerfile/`)
- **Base Image**: Ubuntu Noble with comprehensive development toolchain
- **User Setup**: Creates user 'eg' with sudo access, zsh shell, Oh My Zsh
- **Tools Included**: Build tools, Python, Node.js, debugging tools, Homebrew, Neovim

## Common Development Commands

### Neovim Setup and Management
```bash
# Initial setup (first time)
nvim  # Will automatically bootstrap Lazy.nvim and install plugins

# Plugin management within Neovim
:Lazy install     # Install new plugins
:Lazy update      # Update all plugins  
:Lazy sync        # Install missing and update existing
:Lazy clean       # Remove unused plugins

# LSP and tools management
:Mason            # Open Mason tool installer
:MasonUpdate      # Update Mason registry
:LspInstall <server>  # Install specific LSP server
```

### Tmux Plugin Management
```bash
# Install TPM (if not already installed via git submodule)
git submodule update --init --recursive

# Inside tmux session:
# Prefix + I (Install plugins)
# Prefix + U (Update plugins) 
# Prefix + alt + u (Uninstall plugins)

# Key bindings (prefix is C-a):
# C-a Space - Open tmux menus
# C-a g - Open LazyGit
# C-a Tab - Sidebar toggle
```

### Git Submodule Management
```bash
# Update all submodules (mainly tmux plugins)
git submodule update --remote --recursive

# Add new tmux plugin as submodule
git submodule add <plugin-url> tmux/plugins/<plugin-name>
```

### Docker Development Environment
```bash
# Build development container
docker build -f dockerfile/eglinux-dev.dockerfile -t eglinux-dev .

# Run development container
docker run -it --rm -v $(pwd):/workspace eglinux-dev

# For persistent development
docker run -it --name eglinux-dev-env -v $(pwd):/workspace eglinux-dev
```

## Configuration Patterns

### Neovim Plugin Configuration
- Each plugin gets its own file in `lua/plugins/`
- Uses LazySpec format with lazy loading where appropriate
- Key mappings typically use `<Leader>` (space) prefix
- LSP configurations in `astrolsp.lua`, UI in `astroui.lua`, core in `astrocore.lua`

### Tmux Plugin Integration
- Plugins declared in `tmux.conf` with `set -g @plugin` syntax
- Plugin-specific settings use `@` prefixed variables
- TPM handles installation/updates automatically
- Custom key bindings integrate with plugin functionality

### Cross-Platform Compatibility
- Configurations work on both macOS and Linux
- Docker environment provides consistent Linux development experience
- Homebrew used for package management in containerized environment
- Git configurations set for user 'Eglinux' with development email

## Development Workflow

### Making Configuration Changes
1. **Neovim**: Edit files in `lua/plugins/` or `lua/`, restart nvim or use `:source`
2. **Tmux**: Edit `tmux.conf`, reload with `tmux source-file ~/.config/tmux/tmux.conf`
3. **Docker**: Rebuild container after modifying dockerfile

### Testing Changes
- **Neovim**: Use `:checkhealth` to verify plugin/LSP status
- **Tmux**: Test key bindings and plugin functionality in new session
- **Docker**: Test build process and verify tools are available

### Plugin Management
- **Add Neovim Plugin**: Create new file in `lua/plugins/` following existing patterns
- **Add Tmux Plugin**: Add to `tmux.conf` and update with Prefix+I
- **Community Plugins**: Use AstroNvim community plugins via `community.lua`

## Key File Locations

- **Neovim Entry**: `nvim/init.lua`
- **Plugin Configs**: `nvim/lua/plugins/*.lua`
- **Tmux Config**: `tmux/tmux.conf`
- **Development Container**: `dockerfile/eglinux-dev.dockerfile`
- **Plugin Lock**: `nvim/lazy-lock.json` (should be committed for reproducible setups)

## Important Notes

- This is a personal dotfiles repository for user 'eg/eglinux'
- AstroNvim v5+ is the current version - configurations may not work with v4
- Tmux plugins are managed as git submodules - use proper submodule commands
- Docker environment includes full development toolchain for consistent experience
- All configurations prioritize keyboard-driven workflows with extensive key mappings