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
├── iterm2/            # iTerm2 configuration (Dynamic Profiles)
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
5. **Links iTerm2 profiles** (macOS only) for Nerd Font support
6. **Installs Neovim plugins** via lazy.nvim
7. **Installs Tmux plugins** via TPM (Tmux Plugin Manager)

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

### iTerm2 (macOS)
- **Dynamic Profile**: "Dotfiles" with Nerd Font configured
- **Font**: MesloLGS Nerd Font (for Neovim icons)

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

## iTerm2 Setup (macOS)

The install script automatically links the Dynamic Profile to iTerm2. The "Dotfiles" profile will appear in your profiles list after running `./install.sh`.

To set it as your default profile:

1. Open iTerm2 > Settings (Cmd+,)
2. Go to **Profiles**
3. Select "Dotfiles" from the list
4. Click "Other Actions..." (bottom left)
5. Choose "Set as Default"

This configures iTerm2 to use MesloLGS Nerd Font, which displays icons correctly in Neovim.

