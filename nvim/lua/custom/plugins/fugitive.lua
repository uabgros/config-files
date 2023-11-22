return
{
  'tpope/vim-fugitive',

  cmd = {
    "G",
    "Gread",
  },
  keys = {
    {
      "<leader>fd",
      ":Git difftool<CR>",
      { desc = '[F]ind git [S]tatus' },
    }
  }
}
