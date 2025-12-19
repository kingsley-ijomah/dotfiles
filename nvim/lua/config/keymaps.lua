-- Key Mappings

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Clear search highlighting
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Save file
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<Esc>:w<CR>", opts)

-- Quit
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })

-- Better indenting in visual mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move lines up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Paste without yanking in visual mode
keymap("v", "p", '"_dP', opts)

-- Paste from system clipboard
keymap("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
keymap("n", "<leader>P", '"+P', { desc = "Paste from clipboard (before)" })

-- Copy to system clipboard
keymap("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
keymap("n", "<leader>y", '"+yy', { desc = "Copy line to clipboard" })
keymap("n", "<leader>Y", '"+yG', { desc = "Copy to end of file to clipboard" })

-- Select and copy entire file to clipboard
keymap("n", "<leader>ya", 'gg"+yG', { desc = "Copy entire file to clipboard" })

-- Quick escape from insert mode
keymap("i", "jk", "<Esc>", opts)
keymap("i", "kj", "<Esc>", opts)

-- Split windows
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Equal splits" })
keymap("n", "<leader>sx", ":close<CR>", { desc = "Close split" })

-- Tabs
keymap("n", "<leader>to", ":tabnew<CR>", { desc = "New tab" })
keymap("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
keymap("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
keymap("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Toggle line wrap
keymap("n", "<leader>lw", ":set wrap!<CR>", { desc = "Toggle line wrap" })

-- Quick fix list navigation
keymap("n", "<leader>co", ":copen<CR>", { desc = "Open quickfix" })
keymap("n", "<leader>cq", ":cclose<CR>", { desc = "Close quickfix" })
keymap("n", "]q", ":cnext<CR>zz", { desc = "Next quickfix" })
keymap("n", "[q", ":cprev<CR>zz", { desc = "Prev quickfix" })

-- Search and replace word under cursor
keymap("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search/replace word" })

-- Make file executable
keymap("n", "<leader>x", ":!chmod +x %<CR>", { desc = "Make executable" })

-- Edit nvim config
keymap("n", "<leader>vc", ":Telescope find_files cwd=~/.config/nvim<CR>", { desc = "Search nvim config" })

-- Quick source current file (for Lua config)
keymap("n", "<leader><leader>", function()
  if vim.bo.filetype == "lua" then
    vim.cmd("source %")
    print("Sourced " .. vim.fn.expand("%"))
  end
end, { desc = "Source file" })
