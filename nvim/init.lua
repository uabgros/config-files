--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('i', "jk", "<Esc>", { desc = '' })
_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  lazy = true,

  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {},          -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "gzip",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "matchit",
        "tohtml",
        "tutor",
      },
    },
  },

  { 'nvim-lua/plenary.nvim' },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',
  -- {import 'goran.plugins'},

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/goran/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard       = 'unnamedplus'

-- Enable break indent
vim.o.breakindent     = true

vim.o.timeout         = true
vim.o.timeoutlen      = 300

-- Visual
vim.o.conceallevel    = 0 -- Don't hide quotes in markdown
vim.o.cmdheight       = 1
vim.o.pumheight       = 10
vim.o.showmode        = false
vim.o.showtabline     = 2    -- Always show tabline
vim.o.title           = true
vim.o.termguicolors   = true -- Use true colors, required for some plugins
vim.wo.number         = true
vim.wo.relativenumber = true
vim.wo.signcolumn     = 'yes'
vim.wo.cursorline     = true
-- vim.wo.cursorlineopt  = "number" -- just highlight the line-number
-- vim.wo.cursorcolumn   = false

-- Behaviour
vim.o.hlsearch        = true
vim.o.ignorecase      = true -- Ignore case when using lowercase in search
vim.o.smartcase       = true -- But don't ignore it when using upper case
vim.o.smarttab        = true
vim.o.smartindent     = true
vim.o.expandtab       = true -- Convert tabs to spaces.
vim.o.tabstop         = 2
vim.o.softtabstop     = 2
vim.o.shiftwidth      = 2
vim.o.splitbelow      = true
vim.o.splitright      = true
vim.o.scrolloff       = 12 -- Minimum offset in lines to screen borders
vim.o.sidescrolloff   = 8
vim.o.mouse           = 'a'

-- Vim specific
vim.o.hidden          = true -- Do not save when switching buffers
-- vim.o.fileencoding    = "utf-8"
vim.o.spell           = false
vim.o.spelllang       = "en_us"
-- vim.o.completeopt     = "menuone,noinsert,noselect"
vim.o.completeopt     = "menu,menuone,noselect"
vim.o.wildmode        = "longest,full" -- Display auto-complete in Command Mode
vim.o.updatetime      = 300            -- Delay until write to Swap and HoldCommand event
vim.o.autoread        = true
vim.o.autowrite       = true           -- auto-write on i.e. :make
-- vim.o.swapfile           = false
vim.o.grepprg         = "rg --vimgrep" -- outsource grep to ripgrep
vim.o.grepformat      = "%f:%l:%c:%m"  -- jump to line and column

vim.o.textwidth       = 80

vim.o.sessionoptions  = "buffers,curdir,folds,globals,tabpages,winpos,winsize"

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 900 })
  end,
  group = highlight_group,
  pattern = '*',
})

-- Save undo history
vim.o.undofile = true
vim.cmd [[
  if has('persistent_undo')
    set undofile
    set undodir=~/.nvim/undodir
  endif
]]

-- stick to directory where vim was started (mostly /repo/uabgros/bbi/ to work
-- with :make)
vim.cmd [[
  augroup cdpwd
      autocmd!
      autocmd VimEnter * cd $PWD
  augroup END
]]

-- Remove trailing whitespaces
-- (if a file requires trailing spaces, exclude its type using the regex)
vim.cmd [[autocmd BufWritePre * %s/\s\+$//e ]]

-- Save cursor position in file
vim.cmd [[autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif ]]

-- vim.cmd [[
--   au Colorscheme * hi CursorLineNr guifg=#af00af
--   " au Colorscheme * hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
-- ]]

-- show cursorline only in active window
vim.cmd [[
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
]]

vim.cmd('autocmd BufReadPost fugitive://* set bufhidden=delete') -- don't show fugitive files in bufferlist
vim.cmd('autocmd BufReadPost gitsigns://* set bufhidden=delete') -- don't show gitsigns files in bufferlist

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>qd', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- quit all windows
vim.keymap.set('n', '<leader>qq', ":wa|qa<CR>", { desc = '[Q]uit all windows' })
-- save all buffers
vim.keymap.set('n', "<leader>ww", ":wa<CR>", { desc = '[W]rite all buffers' })
vim.keymap.set({ 'n', 'v' }, "<leader>l", ":nohlsearch<CR>", { desc = 'Redraw screen' })

vim.keymap.set('n', "<C-n>", "lnext<CR>", { desc = '' });
vim.keymap.set('n', "<C-p>", "lprev<CR>", { desc = '' });

-- vim.keymap.set('n', '<leader>k', ':Man<CR><C-w>L', { desc = 'Unix manual page' })

-- Quickfix list
vim.keymap.set('n', "<leader>co", ":copen<CR>", { desc = 'copen' })
vim.keymap.set('n', "<leader>cc", ":cclose<CR>", { desc = 'cclose' })
vim.keymap.set('n', "<C-N>", ":cnext<CR>", { desc = '' })
vim.keymap.set('n', "<C-P>", ":cprev<CR>", { desc = '' })

-- Center after half page up/down
vim.keymap.set('n', "<C-U>", "<C-U>zz", { desc = '' })
vim.keymap.set('n', "<C-D>", "<C-D>zz", { desc = '' })

vim.keymap.set('n', "<leader>*", ":vimgrep //g % | copen<CR>", { desc = 'vimgrep current search pattern' })
vim.keymap.set('n', "<leader>fpg", ":vimgrep //g `git ls-files` | copen<CR>",
  { desc = '[F]ind current Search [P]attern by grep under [G]it-root' })

-- help when e.g. opening a file in current buffers directory
vim.cmd("cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'")

-- ctrl-p/n for navigating :ex-command history
vim.cmd("cnoremap <C-p> <Up>")
vim.cmd("cnoremap <C-n> <Down>")

function Highlight(args)
  vim.cmd('highlight ' .. args)
end

-- Format bazel-files
vim.api.nvim_create_autocmd(
  { "BufWritePre", "FileWritePre" },
  {
    pattern = { "*.bzl", "BUILD" },
    callback = function()
      return require('goran.plugins/telescope-config').bzl_format
    end,
  }
-- command = "%!buildifier" }
)

vim.cmd("hi Visual term=reverse cterm=reverse guibg=Grey")

vim.api.nvim_create_user_command(
  'StartupTime',
  function()
    vim.cmd("Lazy profile")
  end,
  {}
)
-- Visual Maps
vim.keymap.set("v", "<leader>rv", "\"hy:%s/<C-r>h//g<left><left>",
  { desc = "[R]eplace all instances of [V]isually highlighted words" }) --


vim.keymap.set('n', '<leader>j', '<cmd>tabprevious<cr>', { silent = true })
vim.keymap.set('n', '<leader>k', '<cmd>tabnext<cr>', { silent = true })

local function get_session_name()
  local name = vim.fn.getcwd()
  local branch = vim.trim(vim.fn.system("git branch --show-current"))
  if vim.v.shell_error == 0 then
    return name .. branch
  else
    return name
  end
end

local gitBranchSessionLoaded = 0
vim.api.nvim_create_user_command(
  'LoadGitBranchSession',
  function()
    -- code
    if gitBranchSessionLoaded == 0 then
      require('resession').load(get_session_name(), { dir = "dirsession", silence_errors = true })
      gitBranchSessionLoaded = 1
    end
  end,
  {}
)

local lspLoaded = 0
vim.api.nvim_create_user_command(
  'LoadLspSetup',
  function()
    -- code
    if lspLoaded == 0 then
      require('lspsetup')
      lspLoaded = 1
    end
  end,
  {}
)

vim.keymap.set("n", "<leader>R", "<cmd>LoadLspSetup<cr>", { desc = "Start lsp" }) -- reload neovim config

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if gitBranchSessionLoaded == 1 then
      require('resession').save(get_session_name(), { dir = "dirsession", notify = false })
    end
  end,
})

-- vim.keymap.set('n', "<leader>tw", "<Cmd>lua require('goran.plugins.telescope-config').window()<CR>")

vim.api.nvim_create_user_command(
  'ReloadTest',
  function()
    package.loaded.lspsetup = nil
    require("lspsetup").todo()
  end,
  {}
)
