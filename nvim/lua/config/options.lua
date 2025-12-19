-- Basic Neovim Options

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = true
opt.linebreak = true  -- wrap at word boundaries, not mid-word

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = ""

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard (use system clipboard)
opt.clipboard = "unnamedplus"

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Consider - as part of word
opt.iskeyword:append("-")

-- Disable swap files
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Faster completion
opt.updatetime = 300
opt.timeoutlen = 500

-- Better completion experience
opt.completeopt = "menuone,noselect"

-- Scroll offset
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Show matching brackets
opt.showmatch = true

-- Persistent undo
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undodir")

-- Mouse support
opt.mouse = "a"

-- Hide command line when not in use
opt.cmdheight = 1

-- Don't show mode (lualine shows it)
opt.showmode = false

-- Auto-reload files changed outside of Neovim
opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "checktime",
})

-- Auto-save files
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "FocusLost", "BufLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
})
