-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- disable csharpier formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = {},
      },
    },
  },
  -- close neotree after file is opened
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            -- auto close
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
  },
  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- Add cmd location to omnisharp extra
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        omnisharp = {
          cmd = { "/usr/local/bin/omnisharp/OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
          enable_editorconfig_support = true,
          enable_ms_build_load_projects_on_demand = false,
        },
      },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local logo = [[
              	   ``                           
             	  ```                             
            `    ``                `            
             ``  _ `      `       ``            
            `   |_| `  `` ``    `  `            
           ``  -___-_` `   `` ``   ``           
         ``   /      )      ``      `           
        `____/| (0) (0)_()    ``     ``         
       /|   | |   ^____)      ``      ``        
       ||   |_|    \_//     Uɔ````   `` ``      
       ||    || |    |    ========`  ``  ``     
       ||    || |    |      ||     ``   `       
       ||     \\_\   |\     ||   ```    `       
       =========||====||    ||  ``       `      
         || ||   \Ɔ || \Ɔ   ||   ``    ``       
         || ||      ||      ||  `     ``        
         -------------------------------------  
        	         This is fine.                
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
