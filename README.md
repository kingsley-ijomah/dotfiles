# Dotfiles

Personal configuration files for Neovim, Tmux, and Zsh.

## Contents

```
plugins/
├── nvim/          # Neovim configuration (lazy.nvim + 46 plugins)
├── tmux/          # Tmux configuration (TPM + resurrect/continuum)
├── zsh/           # Zsh configuration (aliases, functions)
├── install.sh     # Automated setup script
└── .gitignore
```

## Quick Install

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The install script will:
1. Backup existing configs to `~/.dotfiles_backup_<timestamp>/`
2. Create symlinks to the repo files
3. Install Neovim plugins via lazy.nvim
4. Install Tmux plugins via TPM

## Manual Install

If you prefer manual setup:

### Neovim
```bash
# Backup existing
mv ~/.config/nvim ~/.config/nvim.bak

# Link new config
ln -s /path/to/this/repo/nvim ~/.config/nvim

# Open nvim - lazy.nvim will auto-install plugins
nvim
```

### Tmux
```bash
# Backup existing
mv ~/.tmux.conf ~/.tmux.conf.bak

# Link new config
ln -s /path/to/this/repo/tmux/.tmux.conf ~/.tmux.conf

# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Open tmux and press: prefix + I (Ctrl+a then I)
```

### Zsh
```bash
# Backup existing
mv ~/.zshrc ~/.zshrc.bak

# Link new config
ln -s /path/to/this/repo/zsh/.zshrc ~/.zshrc

# Reload
source ~/.zshrc
```

## What's Included

### Neovim
- **Plugin Manager**: lazy.nvim (46 plugins)
- **LSP**: Full language server support via mason.nvim
- **Completion**: nvim-cmp with snippets
- **Git**: fugitive, gitsigns, lazygit
- **Navigation**: telescope, harpoon, leap
- **Theme**: Catppuccin

### Tmux
- **Prefix**: Ctrl+a (not Ctrl+b)
- **Navigation**: Vim-style (hjkl)
- **Plugins**: resurrect (session save), continuum (auto-save), catppuccin theme
- **History**: 50,000 lines

### Zsh
- **Git aliases**: gs, gc, gp, gpl, gco, gcb, gb, gm, gf, gac, etc.
- **Service management**: PostgreSQL, MongoDB, Redis, ElasticSearch
- **Docker Compose**: dc-up, dc-down, dc-logs, dc-restart, etc.
- **Tmux helpers**: tm, tmn, tma, tmdev

## Requirements

- Neovim 0.9+
- Tmux 3.0+
- Zsh
- Git
- A Nerd Font (for icons)
