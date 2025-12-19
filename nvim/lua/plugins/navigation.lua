-- Navigation and Productivity Plugins
return {
  -- Harpoon: Quick file navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      local keymap = vim.keymap.set

      keymap("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })
      keymap("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

      -- Quick navigation to harpooned files
      keymap("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
      keymap("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
      keymap("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
      keymap("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
      keymap("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Harpoon file 5" })

      -- Navigate harpoon list
      keymap("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
      keymap("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon next" })
    end,
  },

  -- Spectre: Project-wide search and replace
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("spectre").setup({
        open_cmd = "vnew",
        live_update = true,
      })

      local keymap = vim.keymap.set
      keymap("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
      keymap("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = "Search current word" })
      keymap("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search selection" })
      keymap("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search in file" })
    end,
  },

  -- Leap: Quick motion
  {
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-forward)')
      vim.keymap.set({'n', 'x', 'o'}, 'gS', '<Plug>(leap-backward)')
    end,
  },

  -- Todo Comments: Highlight and search TODO/FIXME/etc
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
      vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Find TODOs" })
    end,
  },

  -- Trouble: Better diagnostics list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      local keymap = vim.keymap.set
      keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
      keymap("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics" })
      keymap("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Location List" })
      keymap("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List" })
    end,
  },

  -- Flash: Enhanced f/t/F/T motions
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },
}
