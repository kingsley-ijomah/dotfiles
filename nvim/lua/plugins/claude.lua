-- Claude Code integration
local claude_terminals = {}

local function close_all_claude_windows()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:match("^claude%-") then
      vim.api.nvim_win_close(win, true)
    end
  end
end

local function toggle_claude_terminal(cmd, name)
  local buf_name = "claude-" .. name

  -- Check if THIS specific claude window is open
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local current_name = vim.api.nvim_buf_get_name(buf)
    if current_name:match(buf_name .. "$") then
      -- Same variant is open, close it
      vim.api.nvim_win_close(win, true)
      return
    end
  end

  -- Close any other claude windows first
  close_all_claude_windows()

  -- Check if buffer exists but window is closed, reopen it
  if claude_terminals[name] and vim.api.nvim_buf_is_valid(claude_terminals[name]) then
    vim.cmd("vsplit")
    vim.cmd("wincmd L")
    vim.api.nvim_win_set_buf(0, claude_terminals[name])
    vim.cmd("vertical resize 80")
    vim.cmd("startinsert")
    return
  end

  -- Create new terminal
  vim.cmd("vsplit")
  vim.cmd("wincmd L")
  vim.cmd("terminal " .. cmd)
  vim.cmd("vertical resize 80")
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(buf, buf_name)
  claude_terminals[name] = buf
  vim.cmd("startinsert")
end

-- Claude Code keymaps
vim.keymap.set("n", "<leader>cc", function()
  toggle_claude_terminal("claude", "default")
end, { desc = "Toggle Claude Code" })

vim.keymap.set("n", "<leader>cd", function()
  toggle_claude_terminal("claude --dangerously-skip-permissions", "dangerous")
end, { desc = "Toggle Claude Code (skip permissions)" })

vim.keymap.set("n", "<leader>cr", function()
  toggle_claude_terminal("claude --continue", "continue")
end, { desc = "Toggle Claude Code (resume)" })

vim.keymap.set("n", "<leader>ch", function()
  toggle_claude_terminal("claude --resume", "history")
end, { desc = "Toggle Claude Code (history)" })

-- Double escape to exit terminal mode (for toggling Claude off)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Terminal scrolling keymaps (work in terminal mode)
vim.keymap.set("t", "<C-u>", "<C-\\><C-n><C-u>", { desc = "Scroll up (half page)" })
vim.keymap.set("t", "<C-d>", "<C-\\><C-n><C-d>", { desc = "Scroll down (half page)" })
vim.keymap.set("t", "<C-b>", "<C-\\><C-n><C-b>", { desc = "Scroll up (full page)" })
vim.keymap.set("t", "<C-f>", "<C-\\><C-n><C-f>", { desc = "Scroll down (full page)" })

-- Mouse scroll in terminal mode - use function for reliable handling
vim.keymap.set("t", "<ScrollWheelUp>", function()
  local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>5k", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Mouse scroll up" })

vim.keymap.set("t", "<ScrollWheelDown>", function()
  local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>5j", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Mouse scroll down" })

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
  },
}
