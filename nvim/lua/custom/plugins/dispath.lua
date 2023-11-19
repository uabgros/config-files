return {
  'tpope/vim-dispatch',
  cmd = { 'Make', 'Dispatch' },
  keys = {
    {
      'mt',
      ':wa | Make test ee/lpp/evolved_vm/test/... fm/vim_emca_lib/test/...<CR>',
      desc = '[T]est lpp/vim evolved-vm',
    },
    {
      "<leader>cm",
      ":Copen<CR>",
      mode = 'n',
      desc = 'Copen'
    },
    {
      "<leader>ct",
      ":cclose<CR>:tab Copen<CR>",
      mode = 'n',
      desc = 'cclose : tab Copen',
    },
  }
} -- outsourcing make
