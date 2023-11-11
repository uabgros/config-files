return
{
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
  -- See `:help lualine.txt`

  opts = {
    options = {
      theme = function()
        -- local custom_theme = require 'lualine.themes.Tomorrow'
        -- local custom_theme = require 'lualine.themes.gruvbox'
        -- local custom_theme = require 'lualine.themes.OceanicNext'
        -- local custom_theme = require 'lualine.themes.powerline'
        local custom_theme = require 'lualine.themes.nord'
        -- Change the background of lualine_c section for normal mode
        -- custom_theme.normal.c.bg = '#112233'

        return custom_theme
      end,
      -- icons_enabled = false,
      -- Separators might look weird for certain fonts (eg Cascadia)
      component_separators = '|',
      section_separators = '',
      -- component_separators = { left = '', right = '' },
      -- section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        'filetype',
        {
          function()
            local msg = 'No LSP'
            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()

            if next(clients) == nil then
              return msg
            end

            -- Check for utility buffers
            for ft in non_language_ft do
              if ft:match(buf_ft) then
                return ''
              end
            end

            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes

              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                -- return 'LSP:'..client.name  -- Return LSP name
                return '' -- Only display if no LSP is found
              end
            end

            return msg
          end,
          color = { fg = '#ffffff', gui = 'bold' },
          separator = "",
        },
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'error', 'warn', 'info' },
        },
      },
      lualine_x = {
        {
          'filename',
          -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          path = 2,             -- 2: Absolute path
          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
        },

      },
      lualine_y = { 'progress' },
      lualine_z = {
        { function() return '' end },
        { 'location' },
      }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'filename',
          -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          path = 2,             -- 2: Absolute path
          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
        },
      },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
  },
}
