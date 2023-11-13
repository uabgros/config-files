return
{
  'stevearc/resession.nvim',
  cmd = 'LoadGitBranchSession',
  dependencies = {
    {
      -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        {
          -- show context on top of page
          'nvim-treesitter/nvim-treesitter-context',
          opts = {
            line_numbers = true,
          },

        },

        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      build = ':TSUpdate',

      config = function()
        require 'nvim-treesitter.install'.compilers = { "clang" }

        require('nvim-treesitter.configs').setup {
          -- Add languages to be installed here that you want installed for treesitter
          ensure_installed = { 'c', 'cpp', 'lua', 'python', 'vim' },

          -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
          auto_install = false,

          highlight = { enable = true },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<c-space>',
              node_incremental = '<c-space>',
              scope_incremental = '<c-s>',
              node_decremental = '<M-space>',
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ['<leader>a'] = '@parameter.inner',
              },
              swap_previous = {
                ['<leader>A'] = '@parameter.inner',
              },
            },
          },
        }
      end,
      keys = {
        {
          "_",
          function()
            require("treesitter-context").go_to_context()
          end,
          desc = 'Goto context',
        },
      },
    },

    -- {
    --   "lukas-reineke/indent-blankline.nvim",
    --   main = "ibl",
    --   -- opts = {},
    --   config = function()
    --   require("ibl").setup()
    -- end,
    -- },

    {
      "folke/flash.nvim",
      ---@type Flash.Config
      opts = {},
      -- stylua: ignore
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
        -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        -- { "S", false,                    mode = { "v" } },
        { "r", mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
        {
          "R",
          mode = { "o", "x" },
          function() require("flash").treesitter_search() end,
          desc =
          "Treesitter Search"
        },
        {
          "<c-s>",
          mode = { "c" },
          function() require("flash").toggle() end,
          desc =
          "Toggle Flash Search"
        },
      },
    },

    {
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',

        -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',

        -- Adds a number of user-friendly snippets
        'rafamadriz/friendly-snippets',

        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "zbirenbaum/copilot-cmp",
      },
      config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        require('luasnip.loaders.from_vscode').lazy_load()

        -- luasnip.config.setup {}
        -- local fn = vim.fn
        --
        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          },
          window = {
            completion = {
              border = 'rounded',
              winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
            },
            documentation = {
              border = 'rounded',
              winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
            },
          },

          -- Complete options from the LSP servers and the snippet engine
          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'nvim_lua' },
            { name = 'path' },
            {
              name = 'buffer',
              option = {
                -- Complete from all visible buffers.
                get_bufnrs = function()
                  return vim.api.nvim_list_bufs()
                end,
              },
            },
            { name = 'spell' },
            { name = "treesitter" },
            -- { name = 'copilot' },
            -- {name = 'calc'},
          },
        })
      end,
    },

    {
      'tpope/vim-fugitive',

      keys = {
        {
          "<leader>fd",
          ":Git difftool<CR>",
          { desc = '[F]ind git [S]tatus' },
        }
      }
    },

    {
      -- Adds git releated signs to the gutter, as well as utilities for managing changes
      'lewis6991/gitsigns.nvim',
      opts = {
        -- See `:help gitsigns.txt`
        current_line_blame = true,
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
          vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
            { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
          vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
            { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
          vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk,
            { buffer = bufnr, desc = '[P]review [H]unk' })
        end,
      },
    },

    {
      'rmagatti/goto-preview',
      config = function()
        require('goto-preview').setup {
          default_mappings = true
        }
      end,
      keys = {
        {
          '<C-w>s',
          function()
            vim.cmd(":split")
            require('goto-preview').close_all_win()
          end,
          desc = 'Open buffer in split window',
        },
        {
          '<C-w>v',
          function()
            vim.cmd(":vsplit")
            require('goto-preview').close_all_win()
          end,
          desc = 'Open buffer in vertical split window',
        },
      },
    },

    {
      -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
      },

      config = function()
        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. They will be passed to
        --  the `settings` field of the server config. You must look up that documentation yourself.
        local servers = {
          bashls = {},
          pyright = {},
          marksman = {},
          yamlls = {},
          vimls = {},

          lua_ls = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        }

        -- Setup neovim lua configuration
        require('neodev').setup()

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- Ensure the servers above are installed
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
          automatic_installation = { exclude = { "clangd" } },
          ensure_installed = vim.tbl_keys(servers),
        }

        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(_, bufnr)
          -- auto-format before writing
          vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
          -- turn diagnostics off
          -- vim.cmd("autocmd BufEnter * lua vim.diagnostic.disable()")

          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

          vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover, {
              border = "rounded",
            }
          )

          vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = 'rounded' }
          )

          vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
              signs = true,

              underline = true, -- Enable underline, use default values

              virtual_text = {
                true,
                spacing = 4,
              },

              -- Use a function to dynamically turn signs off
              -- and on, using buffer local variables
              -- signs = function(namespace, bufnr)
              -- return vim.b[bufnr].show_signs == false
              -- end,
              -- Disable a feature
              update_in_insert = true,
            }
          )

          -- NOTE: Remember that lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself
          -- many times.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local nmap = function(keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
          nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

          -- See `:help K` for why this keymap
          nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
          -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

          -- Lesser used LSP functionality
          nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
          nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
          nmap('<leader>wl',
            function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')
          -- Create a command `:Format` local to the LSP buffer
          vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })
        end

        require("lspconfig")["clangd"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = {
            "clangd",
            -- "/proj/bbi_twh/wh_bbi/x86_64-Linux3/fader2_sdk/1.187.1/compiler-clang/bin/clangd",
            -- "--background-index",
            "--suggest-missing-includes",
            "--all-scopes-completion",
            "--completion-style=detailed",
          },
          -- filetypes = { "h", "hh", "c", "cc", "cpp", "objc", "objcpp" },
        })

        mason_lspconfig.setup_handlers {
          function(server_name)
            require('lspconfig')[server_name].setup {
              capabilities = capabilities,
              on_attach = on_attach,
              settings = servers[server_name],
            }
          end,
        }
      end
    }
  },
  opts = {},
}
