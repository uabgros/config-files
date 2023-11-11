return
{
  'voldikss/vim-floaterm',
  cmd = { 'FloatermToggle', 'FloatermNew' },
  config = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.9
  end,
  keys = {
    {
      '<leader><tab>',
      '<cmd>FloatermToggle<cr>',
      mode = { 'n', 't' },
      desc = 'Toggle terminal',
    },
    {
      "<leader>tgh",
      ":FloatermNew --autoclose=0 git lg<CR>",
      desc = 'Run terminal command: [G]it [L]g',
    },
    {
      "<leader>tp",
      "<Cmd>FloatermNew --autoclose=0 ps fux<CR>",
      desc = 'Run terminal command: [p]s fux',
    },
    {
      "<leader>tt",
      desc = '[T]est lpp\'s basic functions',
      "<Cmd>FloatermNew --autoclose=0 bbi_bazel test ee/lpp/evolved_vm/test/... fm/vim_emca_lib/test/...<CR>",
    },
  },
}
