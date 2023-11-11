return
{
  'stevearc/oil.nvim',
  -- event = "InsertEnter",
  cmd = 'Oil',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      '-',
      function()
        require("oil").open()
      end,
      desc = "Open parent directory",
    }
  }
}
