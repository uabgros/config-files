-- Fuzzy Finder (files, lsp, etc)
return {
  { 'nvim-lua/plenary.nvim' },

  {
    'nvim-telescope/telescope.nvim',
    --event = "VeryLazy",
    branch = '0.1.x',
    cmd = { 'Telescope' },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        --event = "VeryLazy",
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
        config = function()
          -- Enable telescope fzf native, if installed
          require('telescope').load_extension('fzf')
        end,
      },
    },
    opts = {
      defaults = {
        layout_strategy = "vertical",
        -- initial_mode = "normal",
        initial_mode = "insert",
        winblend = 0,
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        }
      }
    },
    keys = {
      {
        '<leader>?',
        function()
          require('telescope.builtin').oldfiles()
        end,
        desc = '[?] Find recently opened files',
      },
      {
        '<leader>/',
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = true,
          })
        end,
        desc = '[/] Fuzzily search in current buffer',
      },
      {
        '<leader>ff',
        function()
          local gopts = {}

          gopts.prompt_title = " Find"
          gopts.prompt_prefix = "  "
          gopts.results_title = " Repo Files"
          gopts.path_display = { "absolute" }
          gopts.file_ignore_patterns = {
            "build_aas/",
            "projects/",
            "legacy/llpp/",
            "meta-bbi",
          }
          require("telescope.builtin").git_files(gopts)
        end,
        desc = '[F]ind [F]ile',
      },
      {
        "<leader>fq",
        function()
          vim.ui.input({ prompt = "Directory: ", default = vim.fn.getcwd(), completion = "dir" }, function(dir)
            dir = vim.trim(dir or "")
            if dir == "" then
              return
            end

            require("telescope.builtin").find_files {
              prompt_title = "Find file \"" .. vim.fn.expand("<cword>") .. "\" under directory: " .. dir,
              results_title = "Files Results",
              path_display = { "smart" },
              search_dirs = { dir },
              search_file = vim.fn.expand("<cword>"),
            }
          end)
        end,
        desc = '[F]ind [C]urrent file',
      },
      {
        "<leader>ds",
        function()
          local opts = {
            layout_config = { width = 0.9 },
            show_line = true,
            fname_width = 30,
            symbol_width = 60,
          }
          require('telescope.builtin').lsp_document_symbols(opts)
        end,
        desc = '[D]ocument [S]ymbols',
      },
      {
        "<leader>fwe",
        function()
          local opts = {
            -- word_match = { "-w" }, -- exact word match
          }

          opts.search_dirs = {
            -- "/repo/uabgros/bbi",
            "/repo/uabgros/bbi/iw",
            "/repo/uabgros/bbi/ee/lpp",
            "/repo/uabgros/bbi/fm/eqmh",
            "/repo/uabgros/bbi/fm/vim_emca_lib",
            "/repo/uabgros/bbi/tools/bait",
          }
          opts.prompt_title = 'Find exact word \'' .. vim.fn.expand("<cword>") .. '\' under evolved_vm and eqmh'
          opts.path_display = { "absolute" }
          opts.word_match = { "-w" } -- exact word match

          require("telescope.builtin").grep_string(opts)
        end,
        desc = '[F]ind [W]ord by grep in [E]volved Vm',
      },
      {
        "<leader>fwl",
        function()
          local opts = {}
          opts.search_dirs = {
            "/repo/uabgros/bbi/iw",
            "/repo/uabgros/bbi/legacy/lpp",
            "/repo/uabgros/bbi/fm/hypervisor",
            "/repo/uabgros/bbi/fm/eqmh",
            "/repo/uabgros/bbi/tools/bait",
          }
          opts.prompt_title = 'Find exact word \'' .. vim.fn.expand("<cword>") .. '\' under evolved_vm and eqmh'
          -- opts.layout_strategy = 'vertical'
          -- opts.path_display = { "smart" }
          -- opts.path_display = { "shorten" }
          opts.path_display = { "absolute" }
          opts.word_match = { "-w" } -- exact word match
          require("telescope.builtin").grep_string(opts)
        end,
        desc = '[F]ind [W]ord by grep in [L]egacy',
      },
      {
        "<leader>fwg",
        function()
          local opts = {
            path_display = { "absolute" },
            search_dirs = { "/repo/uabgros/bbi" },
            prompt_title = "Find exact word \"" .. vim.fn.expand("<cword>") .. "\" under directory: /repo/uabgros/bbi",
            word_match = { "-w" } -- exact word match
          }
          require("telescope.builtin").grep_string(opts)
        end,
        desc = '[Find] [W]ord by grep under [G]it-root',
      },
      {
        "<leader>fww",
        function()
          vim.ui.input({ prompt = "Directory: ", default = vim.fn.getcwd(), completion = "dir" }, function(dir)
            dir = vim.trim(dir or "")
            if dir == "" then
              return
            end

            local opts = {
              path_display = { "absolute" },
              search_dirs = { dir },
              prompt_title = "Find \"" .. vim.fn.expand("<cword>") .. "\" under directory: " .. dir,
              word_match = { "-w" } -- exact word match
            }
            require("telescope.builtin").grep_string(opts)
          end)
        end,
        desc = '[Find] [W]ord by grep [W]here?',
      },
      {
        "<leader>fgd",
        function()
          -- vim.ui.input({ prompt = "Directory: ", default = "~/", completion = "dir" }, function(dir)
          vim.ui.input({ prompt = "Directory: ", default = vim.fn.getcwd(), completion = "dir" }, function(dir)
            dir = vim.trim(dir or "")
            if dir == "" then
              return
            end

            vim.ui.input({ prompt = "File pattern: ", default = "*" }, function(pattern)
              pattern = vim.trim(pattern or "")
              if pattern == "" then
                return
              end

              local args = require("telescope.config").values.vimgrep_arguments
              if pattern ~= "*" then
                vim.list_extend(args, { "-g", pattern })
              end

              require("telescope.builtin").live_grep({
                search_dirs = { dir },
                -- layout_strategy = 'vertical',
                vimgrep_arguments = args,
              })
            end)
          end)
        end,
        desc = '[F]ind by [G]rep in [D]iretory',
      },
      {
        "<leader>fo",
        function()
          require('telescope.builtin').oldfiles()
        end,
        desc = '[F]ind [O]ld files',
      },
      {
        "<leader>fb",
        function()
          require('telescope.builtin').buffers({ ignore_current_buffer = true, sort_mru = true })
        end,
        desc = '[F]ind [B]uffers',
      },
      {
        "<leader>fc",
        function()
          local opts = {
            initial_mode = "normal",
          }
          require('telescope.builtin').command_history(opts)
        end,
        desc = '[F]ind [C]ommand history',
      },
      {
        "<leader>fj",
        function()
          local opts = {
            fname_width = 100,
            trim_text = true,
          }
          require("telescope.builtin").jumplist(opts)
        end,
        desc = '[F]ind [J]ump-list',
      },
      {
        "<leader>fk",
        function()
          require('telescope.builtin').keymaps()
        end,
        desc = '[F]ind [K]eymap',
      },
      {
        "<leader>fm",
        function()
          require('telescope.builtin').marks()
        end,
        desc = '[F]ind [M]arks',
      },
      {
        "<leader>fh",
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = '[F]ind [H]elp-tags',
      },
      {
        'gr',
        function()
          require('telescope.builtin').lsp_references { fname_width = 60, }
        end,
        desc = '[G]oto [R]eferences',
      },
    },
  },
}
