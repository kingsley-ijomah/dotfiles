#!/bin/bash
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Backup existing configs
backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir"

echo "Creating backup at: $backup_dir"

# Neovim
if [ -e "$HOME/.config/nvim" ]; then
    echo "Backing up existing nvim config..."
    mv "$HOME/.config/nvim" "$backup_dir/"
fi
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
echo "✓ Neovim config linked"

# Tmux
if [ -e "$HOME/.tmux.conf" ]; then
    echo "Backing up existing tmux config..."
    mv "$HOME/.tmux.conf" "$backup_dir/"
fi
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
echo "✓ Tmux config linked"

# Zsh
if [ -e "$HOME/.zshrc" ]; then
    echo "Backing up existing zshrc..."
    mv "$HOME/.zshrc" "$backup_dir/"
fi
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
echo "✓ Zsh config linked"

# Install Neovim plugins
echo "Installing Neovim plugins..."
nvim --headless "+Lazy! sync" +qa 2>/dev/null
echo "✓ Neovim plugins installed"

# Install Tmux plugins (TPM)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
echo "Installing Tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins
echo "✓ Tmux plugins installed"

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
