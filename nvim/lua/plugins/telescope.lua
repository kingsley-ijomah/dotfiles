-- Telescope: Fuzzy Finder
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "dist/",
          "build/",
          "__pycache__",
          "*.pyc",
          ".venv",
          "venv",
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    telescope.load_extension("fzf")

    -- Keymaps
    local keymap = vim.keymap.set
    local builtin = require("telescope.builtin")

    keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    keymap("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
    keymap("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    keymap("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
    keymap("n", "<leader>fs", builtin.grep_string, { desc = "Find string under cursor" })
    keymap("n", "<leader>fc", builtin.git_commits, { desc = "Git commits" })
    keymap("n", "<leader>ft", builtin.git_status, { desc = "Git status" })
    keymap("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
    keymap("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
    keymap("n", "<C-p>", builtin.find_files, { desc = "Find files (Ctrl+P)" })
  end,
}
