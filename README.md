# Dotfiles

Personal configuration files for Neovim, Tmux, Zsh, and Oh My Zsh.

## Contents

```
dotfiles/
├── nvim/              # Neovim configuration (lazy.nvim + plugins)
├── tmux/              # Tmux configuration (.tmux.conf)
├── zsh/               # Zsh configuration (.zshrc)
├── oh-my-zsh/         # Custom Oh My Zsh themes
│   └── custom/
│       └── themes/
└── install.sh         # Automated setup script
```

## Installation

### 1. Clone to home directory

```bash
git clone git@github.com:kingsley-ijomah/dotfiles.git ~/dotfiles
```

### 2. Run the install script

```bash
cd ~/dotfiles
./install.sh
```

### 3. Reload your shell

```bash
source ~/.zshrc
```

## What the install script does

1. **Creates backups** of existing configs to `~/.dotfiles_backup_<timestamp>/`
2. **Symlinks configurations**:
   - `~/.config/nvim` → `~/dotfiles/nvim`
   - `~/.tmux.conf` → `~/dotfiles/tmux/.tmux.conf`
   - `~/.zshrc` → `~/dotfiles/zsh/.zshrc`
3. **Installs Oh My Zsh** (if not already installed)
4. **Copies custom themes** to `~/.oh-my-zsh/custom/themes/`
5. **Installs Neovim plugins** via lazy.nvim
6. **Installs Tmux plugins** via TPM (Tmux Plugin Manager)

## What's Included

### Neovim
- **Plugin Manager**: lazy.nvim
- **LSP**: Full language server support via mason.nvim
- **Completion**: nvim-cmp with snippets
- **Git**: fugitive, gitsigns, lazygit
- **Navigation**: telescope, harpoon, leap
- **Theme**: Solarized

### Tmux
- **Prefix**: `Ctrl+a` (not Ctrl+b)
- **Navigation**: Vim-style (hjkl)
- **Plugins**: resurrect (session save), continuum (auto-save)
- **History**: 50,000 lines

### Zsh / Oh My Zsh
- **Theme**: codehance (custom)
- **Git aliases**: gs, gc, gp, gpl, gco, gcb, gb, gm, gf, gac, etc.
- **Service management**: PostgreSQL, MongoDB, Redis, ElasticSearch
- **Docker Compose**: dc-up, dc-down, dc-logs, dc-restart, etc.
- **Tmux helpers**: tm, tmn, tma, tmdev

## Requirements

- Neovim 0.9+
- Tmux 3.0+
- Zsh
- Git
- curl (for Oh My Zsh installation)
- A Nerd Font (for icons)

## Updating

To pull the latest changes:

```bash
cd ~/dotfiles
git pull
./install.sh
```

The install script is safe to run multiple times - it will update symlinks and reinstall plugins as needed.
