return
{
  -- 'christoomey/vim-tmux-navigator',
  -- event = "VeryLazy",
  'alexghergh/nvim-tmux-navigation',
  opts = {},
  keys = {
    {
      '<C-h>',
      '<Cmd>NvimTmuxNavigateLeft<CR>',
      mode = { 'n' },
    },
    {
      '<C-j>',
      '<Cmd>NvimTmuxNavigateDown<CR>',
      mode = { 'n' },
    },
    {
      '<C-k>',
      '<Cmd>NvimTmuxNavigateUp<CR>',
      mode = { 'n' },
    },
    {
      '<C-l>',
      '<Cmd>NvimTmuxNavigateRight<CR>',
      mode = { 'n' },
    },
  },
}
