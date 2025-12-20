#!/bin/bash
set -e  # Exit on error

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Backup existing configs
backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir"

echo "Creating backup at: $backup_dir"

# Neovim
if [ -e "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    echo "Backing up existing nvim config..."
    mv "$HOME/.config/nvim" "$backup_dir/"
elif [ -L "$HOME/.config/nvim" ]; then
    rm "$HOME/.config/nvim"
fi
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
echo "✓ Neovim config linked"

# Tmux
if [ -e "$HOME/.tmux.conf" ] && [ ! -L "$HOME/.tmux.conf" ]; then
    echo "Backing up existing tmux config..."
    mv "$HOME/.tmux.conf" "$backup_dir/"
elif [ -L "$HOME/.tmux.conf" ]; then
    rm "$HOME/.tmux.conf"
fi
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
echo "✓ Tmux config linked"

# Oh My Zsh - backup existing installation before any modifications
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Backing up existing Oh My Zsh..."
    # Use rsync to handle symlinks properly and avoid cycles
    if command -v rsync &> /dev/null; then
        rsync -a --exclude='*.swp' "$HOME/.oh-my-zsh/" "$backup_dir/oh-my-zsh/" 2>/dev/null || true
    else
        # Fallback: copy without following symlinks
        cp -R "$HOME/.oh-my-zsh" "$backup_dir/oh-my-zsh" 2>/dev/null || true
    fi
    echo "✓ Oh My Zsh backed up"
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "✓ Oh My Zsh installed"
else
    echo "✓ Oh My Zsh already installed"
fi

# Symlink custom oh-my-zsh themes
if [ -d "$DOTFILES_DIR/oh-my-zsh/custom/themes" ] && [ "$(ls -A "$DOTFILES_DIR/oh-my-zsh/custom/themes" 2>/dev/null)" ]; then
    echo "Linking custom oh-my-zsh themes..."
    mkdir -p "$HOME/.oh-my-zsh/custom/themes"
    for theme in "$DOTFILES_DIR/oh-my-zsh/custom/themes/"*; do
        [ -e "$theme" ] || continue
        theme_name=$(basename "$theme")
        rm -f "$HOME/.oh-my-zsh/custom/themes/$theme_name"
        ln -sf "$theme" "$HOME/.oh-my-zsh/custom/themes/$theme_name"
    done
    echo "✓ Custom themes linked"
fi

# Symlink custom oh-my-zsh plugins (if any)
if [ -d "$DOTFILES_DIR/oh-my-zsh/custom/plugins" ] && [ "$(ls -A "$DOTFILES_DIR/oh-my-zsh/custom/plugins" 2>/dev/null)" ]; then
    echo "Linking custom oh-my-zsh plugins..."
    mkdir -p "$HOME/.oh-my-zsh/custom/plugins"
    for plugin in "$DOTFILES_DIR/oh-my-zsh/custom/plugins/"*; do
        [ -e "$plugin" ] || continue
        plugin_name=$(basename "$plugin")
        rm -rf "$HOME/.oh-my-zsh/custom/plugins/$plugin_name"
        ln -sf "$plugin" "$HOME/.oh-my-zsh/custom/plugins/$plugin_name"
    done
    echo "✓ Custom plugins linked"
fi

# Zsh
if [ -e "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "Backing up existing zshrc..."
    mv "$HOME/.zshrc" "$backup_dir/"
elif [ -L "$HOME/.zshrc" ]; then
    rm "$HOME/.zshrc"
fi
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
echo "✓ Zsh config linked"

# Install Neovim plugins (only if nvim is available)
if command -v nvim &> /dev/null; then
    echo "Installing Neovim plugins..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
    echo "✓ Neovim plugins installed"
else
    echo "⚠ Neovim not found, skipping plugin installation"
fi

# Install Tmux plugins (TPM)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
    echo "Installing Tmux plugins..."
    ~/.tmux/plugins/tpm/bin/install_plugins || true
    echo "✓ Tmux plugins installed"
else
    echo "⚠ TPM install script not found, skipping plugin installation"
fi

echo ""
echo "=========================================="
echo "Dotfiles installed successfully!"
echo "Backup location: $backup_dir"
echo ""
echo "Next steps:"
echo "  1. Run: source ~/.zshrc"
echo "  2. Open nvim - plugins should be ready"
echo "  3. Open tmux - plugins should be ready"
echo "=========================================="
