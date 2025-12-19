-- Git Integration
return {
  -- Gitsigns: Git decorations
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 500,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local keymap = vim.keymap.set

          -- Navigation
          keymap("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Next hunk" })

          keymap("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Previous hunk" })

          -- Actions
          keymap("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
          keymap("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
          keymap("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { buffer = bufnr, desc = "Stage hunk" })
          keymap("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { buffer = bufnr, desc = "Reset hunk" })
          keymap("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
          keymap("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
          keymap("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
          keymap("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
          keymap("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { buffer = bufnr, desc = "Blame line" })
          keymap("n", "<leader>tb", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle blame" })
          keymap("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Diff this" })
          keymap("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { buffer = bufnr, desc = "Diff this ~" })
          keymap("n", "<leader>td", gs.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })
        end,
      })
    end,
  },

  -- Fugitive: Git commands
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
    keys = {
      { "<leader>gs", ":Git<CR>", desc = "Git status" },
      { "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
      { "<leader>gp", ":Git push<CR>", desc = "Git push" },
      { "<leader>gl", ":Git pull<CR>", desc = "Git pull" },
      { "<leader>gb", ":Git blame<CR>", desc = "Git blame" },
      { "<leader>gd", ":Gdiffsplit<CR>", desc = "Git diff" },
    },
  },

  -- Lazygit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", ":LazyGit<CR>", desc = "LazyGit" },
    },
  },
}
