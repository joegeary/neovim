return {
  {
    "preservim/vim-markdown",
    dependencies = {
      "godlygeek/tabular",
    },
    ft = { "markdown" },
  },

  -- Markdown previewing
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
    keys = {
      { "n", "<leader>mp", "<Plug>MarkdownPreviewToggle", desc = "Markdown preview" },
    },
  },
}
