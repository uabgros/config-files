-- telescope-config.lua
local M = {}
-- local utils = require "telescope.utils"

-- local function is_git()
--   local _, ret, stderr = utils.get_os_command_output {
--     "git",
--     "rev-parse",
--     "--is-inside-work-tree",
--   }
--   return ret
-- end

local function path_remainder(fname_width, path)
  local str_len = string.len(path);
  if str_len > fname_width then
    str_len = fname_width
  end
  return string.sub(path, -str_len)
end


function M.find_configs()
  require("telescope.builtin").find_files {
    prompt_title = " NVim & Term Config Find",
    results_title = "Config Files Results",
    path_display = { "smart" },
    search_dirs = {
      "~/git/dotfiles",
    },
  }
end

function M.git_status()
  local opts = {}
  -- opts.layout_strategy = 'horizontal'
  opts.show_line = true
  require("telescope.builtin").git_status(opts)
end

function M.symbol_reference()
  local opts = {
    path_display = { "smart" },
    layout_config = { width = 0.9 },
    fname_width = 60,
  }
  require("telescope.builtin").lsp_references(opts)
end

function M.dyn_ws_symbols()
  local opts = {
    fname_width = 80,
    path_display = function(opts, path)
      return path_remainder(fname_width, path)
    end,
    layout_config = { width = 0.9 },
  }
  require('telescope.builtin').lsp_dynamic_workspace_symbols(opts)
end

function M.query_symbol()
  local opts = {
    layout_config = { width = 0.9 },
    show_line = true,
    fname_width = 80,
    query = vim.fn.expand("<cword>"),
    prompt_title = 'Find symbol \'' .. vim.fn.expand("<cword>") .. '\'',
    path_display = function()
      return path_remainder(fname_width, path)
    end,
  }
  require('telescope.builtin').lsp_workspace_symbols(opts)
end

function M.git_bcommits()
  local opts = {
    layout_config = { width = 0.9 },
    show_line = true,
    fname_width = 80,
    path_display = function()
      return path_remainder(fname_width, path)
    end,
  }
  require('telescope.builtin').git_bcommits(opts)
end

function M.quickfix_tab()
  vim.api.nvim_command('cclose')
  vim.api.nvim_command('tab Copen')
end

function M.window()
  local width = 50
  local height = 10
  local buf = vim.api.nvim_create_buf(false, true)

  local opts = {
    relative = 'cursor',
    width = width,
    height = height,
    col = 3,
    row = 3,
    anchor = 'NE',
    style = 'minimal',
    border = 'single',
  }
  vim.api.nvim_open_win(buf, true, opts)
  local term_id = vim.api.nvim_open_term(buf, {})
  local function send_output(_, data, _)
    for _, d in ipairs(data) do
      vim.api.nvim_chan_send(term_id, data .. "\n")
    end
  end
  vim.fn.jobstart("command that produces a colored output", { on_stdout = send_output })
end

function M.bzl_format()
  vim.api.nvim_command('%!buildifier')
end

return M
--
-- call via:
-- :lua require"telescope-config".project_files()

-- example keymap:
-- vim.api.nvim_set_keymap("n", "<Leader><Space>", "<CMD>lua require'telescope-config'.project_files()<CR>", {noremap = true, silent = true})
