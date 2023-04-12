return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup {
        hint_enable = false,
      }
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
    },
    init = function()
      require("noice").setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = {
            enabled = false,
          },
          signature = {
            enabled = false,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  {
    "gen740/SmoothCursor.nvim",
    init = function()
      require("smoothcursor").setup {
        autostart = true,
        cursor = "", -- cursor shape (need nerd font)
        texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
        linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
        type = "default", -- define cursor movement calculate function, "default" or "exp" (exponential).
        fancy = {
          enable = false, -- enable fancy mode
          head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
          body = {
            { cursor = "", texthl = "SmoothCursorRed" },
            { cursor = "", texthl = "SmoothCursorOrange" },
            { cursor = "●", texthl = "SmoothCursorYellow" },
            { cursor = "●", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = ".", texthl = "SmoothCursorBlue" },
            { cursor = ".", texthl = "SmoothCursorPurple" },
          },
          tail = { cursor = nil, texthl = "SmoothCursor" },
        },
        flyin_effect = nil, -- "bottom" or "top"
        speed = 25, -- max is 100 to stick to your current position
        intervals = 35, -- tick interval
        priority = 10, -- set marker priority
        timeout = 3000, -- timout for animation
        threshold = 3, -- animate if threshold lines jump
        disable_float_win = false, -- disable on float window
        enabled_filetypes = nil, -- example: { "lua", "vim" }
        disabled_filetypes = nil, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
      }
    end,
  },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    init = function() require("leap").add_default_mappings() end,
  },
  {
    "rcarriga/nvim-notify",
    enabled = true,
    init = function()
      require("notify").setup {
        background_colour = "#000000",
      }
    end,
  },
  {
    "natecraddock/workspaces.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-file-browser.nvim",
        init = function() require("telescope").load_extension "file_browser" end,
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
      },
    },
    init = function()
      require("workspaces").setup {
        hooks = {
          open = { "Telescope file_browser" },
        },
      }
      require("telescope").load_extension "workspaces"
    end,
  },
  {
    "marko-cerovac/material.nvim",
    dependencies = {
      {
        "nvim-lualine/lualine.nvim",
        init = function() require("lualine").setup {} end,
      },
    },
    init = function()
      vim.g.material_style = "deep ocean"
      require("material").setup {

        contrast = {
          terminal = false, -- Enable contrast for the built-in terminal
          sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
          floating_windows = false, -- Enable contrast for floating windows
          cursor_line = false, -- Enable darker background for the cursor line
          non_current_windows = false, -- Enable darker background for non-current windows
          filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
        },

        styles = {
          -- Give comments style such as bold, italic, underline etc.
          comments = { italic = true, bold = true },
          strings = { italic = true, undercurl = true },
          keywords = { italic = true, bold = true },
          functions = { bold = true, undercurl = true, italic = true },
          variables = {},
          operators = {},
          types = {},
        },

        plugins = { -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          "dap",
          -- "dashboard",
          "gitsigns",
          -- "hop",
          -- "indent-blankline",
          -- "lspsaga",
          -- "mini",
          -- "neogit",
          -- "neorg",
          "nvim-cmp",
          -- "nvim-navic",
          "nvim-tree",
          "nvim-web-devicons",
          -- "sneak",
          "telescope",
          "trouble",
          "which-key",
        },

        disable = {
          colored_cursor = false, -- Disable the colored cursor
          borders = false, -- Disable borders between verticaly split windows
          background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false, -- Prevent the theme from setting terminal colors
          eob_lines = false, -- Hide the end-of-buffer lines
        },

        high_visibility = {
          lighter = false, -- Enable higher contrast text for lighter style
          darker = false, -- Enable higher contrast text for darker style
        },

        lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

        async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

        custom_colors = nil, -- If you want to everride the default colors, set this to a function

        custom_highlights = {}, -- Overwrite highlights with your own
      }
    end,
  },
  {
    "lkhphuc/jupyter-kernel.nvim",
    opts = {
      inspect = {
        -- opts for vim.lsp.util.open_floating_preview
        window = {
          max_width = 84,
        },
      },
      -- time to wait for kernel's response in seconds
      timeout = 0.5,
    },
    cmd = { "JupyterAttach", "JupyterInspect", "JupyterExecute" },
    build = ":UpdateRemotePlugins",
    keys = { { "<leader>k", "<Cmd>JupyterInspect<CR>", desc = "Inspect object in kernel" } },
  },
}
