-- Neovim Configuration
-- A modern IDE-like setup for Python and JavaScript/TypeScript

-- Set leader key before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.wo.number = true
vim.wo.relativenumber = true

-- Load core configurations
require("config.options")
require("config.lazy")
require("config.keymaps")
