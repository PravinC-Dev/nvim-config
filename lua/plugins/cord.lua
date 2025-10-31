return {
  {
    'vyfor/cord.nvim',
    event = 'VeryLazy',
    build = ':Cord update fetch',

    config = function()
      require('cord').setup({
        -- Enable the plugin
        enabled = true,

        -- Basic configuration
        editor = {
          client = 'neovim', -- Ensure correct client is set
          tooltip = "The Superior Text Editor"
        },

        -- Display settings
        display = {
          theme = 'atom', -- Using default theme for better compatibility
          flavor = 'dark',
        },

        -- Privacy-focused text configuration
        text = {
          -- Show a generic workspace name instead of hiding it completely
          workspace = "Working in Neovim",

          -- Generic editing message showing only language, not filename
          editing = function(opts)
            if opts.filetype and opts.filetype ~= "" then
              return "Coding in " .. opts.filetype
            else
              return "Writing code"
            end
          end,

          -- Generic viewing message
          viewing = function(opts)
            if opts.filetype and opts.filetype ~= "" then
              return "Working with " .. opts.filetype
            else
              return "Viewing code"
            end
          end,

          -- Hide file browser details
          file_browser = "Browsing files",

          -- Hide terminal details
          terminal = "Using terminal",

          -- Hide dashboard details
          dashboard = "At home screen"
        },

        buttons = {
          {
            label = function(opts)
              local docs = {
                rust            = 'Rust Docs',
                typescript      = 'TS Docs',
                typescriptreact = 'TSX Docs',
                jsx             = 'JSX Docs',
                lua             = 'Lua Reference',
                python          = 'Python Docs',
                go              = 'Go Docs',
                java            = 'Java Docs',
                html            = 'HTML Reference',
                css             = 'CSS Reference',
                json            = 'JSON Docs',
                bash            = 'Bash Reference',
              }
              return docs[opts.filetype] or 'Documentation'
            end,
            url = function(opts)
              local urls = {
                rust            = 'https://doc.rust-lang.org/std/',
                typescript      = 'https://www.typescriptlang.org/docs/',
                typescriptreact = 'https://react-typescript-cheatsheet.netlify.app/',
                jsx             = 'https://reactjs.org/docs/introducing-jsx.html',
                lua             = 'https://www.lua.org/manual/5.1/',
                python          = 'https://docs.python.org/3/',
                go              = 'https://pkg.go.dev/std',
                java            = 'https://docs.oracle.com/javase/8/docs/api/',
                html            = 'https://developer.mozilla.org/en-US/docs/Web/HTML',
                css             = 'https://developer.mozilla.org/en-US/docs/Web/CSS',
                json            = 'https://www.json.org/json-en.html',
                bash            = 'https://www.gnu.org/software/bash/manual/bash.html',
              }
              return urls[opts.filetype] or 'https://devdocs.io'
            end
          }
        },

        -- Idle settings
        idle = {
          enabled = true,
          timeout = 300000, -- 10 minutes
          details = "Away from keyboard",
          state = "Idle",
          ignore_focus = false
        },

        -- Timestamp showing how long you've been coding
        timestamp = {
          enabled = true,
          reset_on_idle = false,
        }
      })

      -- Start the service immediately
      vim.schedule(function()
        vim.cmd("Cord enable")
      end)
    end
  }
}
