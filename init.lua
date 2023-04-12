return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "material",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    local get_hlgroup = require("astronvim.utils").get_hlgroup
    -- get highlights from highlight groups
    local normal = get_hlgroup "Normal"
    local fg, bg = normal.fg, normal.bg
    local bg_alt = get_hlgroup("Visual").bg
    local green = get_hlgroup("String").fg
    local red = get_hlgroup("Error").fg
    -- return a table of highlights for telescope based on colors gotten from highlight groups
    local hlList = {
      TelescopeBorder = { fg = bg_alt, bg = bg },
      TelescopeNormal = { bg = bg },
      TelescopePreviewBorder = { fg = bg, bg = bg },
      TelescopePreviewNormal = { bg = bg },
      TelescopePreviewTitle = { fg = bg, bg = green },
      TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
      -- TelescopePromptNormal = { fg = fg, bg = bg_alt },
      -- TelescopePromptPrefix = { fg = red, bg = bg_alt },
      TelescopePromptTitle = { fg = bg, bg = red },
      TelescopeResultsBorder = { fg = bg, bg = bg },
      TelescopeResultsNormal = { bg = bg },
      TelescopeResultsTitle = { fg = bg, bg = bg },
    }
    for group, highlights in pairs(hlList) do
      vim.api.nvim_set_hl(0, group, highlights)
    end
  end,
}
