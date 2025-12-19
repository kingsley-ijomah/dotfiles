return {
  -- Render markdown nicely within Neovim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {
      heading = {
        enabled = true,
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
      },
      code = {
        enabled = true,
        style = "full",
        border = "thin",
      },
    },
    keys = {
      { "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown Render" },
    },
  },
}
