return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- for file icons
    "folke/trouble.nvim",
    "SmiteshP/nvim-navic",
  },
  config = function()
    require('lualine').setup({
      sections = {
        lualine_a = {
          { "mode", separator = { right = ""}, right_padding = 0 },
        },
        lualine_b = {"branch"}, --"diff"

        lualine_c = {
          -- 1. Your original diagnostics component (unchanged)
          { "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn", "hint" },
            symbols = { error = " ", warn = " ", hint = " " },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
          -- 2. OPTIMIZED "smart" component with lazy initialization
          function()
            -- On the first run, create the component object.
            -- This is only executed once.
            if trouble_symbols_component == nil then
              trouble_symbols_component = require("trouble").statusline({
                mode = "symbols",
                filter = { range = true },
                format = "{kind_icon} {symbol.name}",
                title = false,
              })
            end

            -- Check if trouble is available and call the `.has()` method
            -- on our now-initialized component.
            if package.loaded["trouble"] and trouble_symbols_component.has() then
              -- If yes, call the fast `.get()` method.

              local raw_output = select(1, trouble_symbols_component.get())
              -- This more specific pattern explicitly matches the digits (%d+)
              -- and surrounding spaces to ensure the whole component is removed.
              local cleaned_output = string.gsub(raw_output, " %%#TroubleLspCount# %d+ %%%*", " ")
              return cleaned_output

            else
              -- If no, fall back to your original filename function
              local filename = vim.fn.expand("%:t")
              local ext = vim.fn.expand("%:e")
              local devicons = require("nvim-web-devicons")
              local icon, icon_hl = devicons.get_icon(filename, ext, { default = true })
              if icon and icon_hl then
                icon = string.format("%%#%s#%s%%*", icon_hl, icon)
              end
              local relative = vim.fn.expand("%:.")
              local sep = package.config:sub(1, 1)
              local parts = {}
              for part in string.gmatch(relative, "[^" .. sep .. "]+") do
                table.insert(parts, part)
              end
              if #parts == 0 then
                return icon .. "  " .. relative
              end
              local leaf = parts[#parts]
              local dir = (#parts > 1) and table.concat(parts, sep, 1, #parts - 1) or ""
              if dir ~= "" then
                return icon .. " " .. "%#LualineDir#" .. dir .. "%*" .. sep .. "%#LualineFileNameBold#" .. leaf .. "%*"
              else
                return icon .. "  " .. "%#LualineFileNameBold#" .. leaf .. "%*"
              end
            end
          end,
        },
        lualine_x = {
          {
            function()
              local gs = vim.b.gitsigns_status_dict or {}
              local added = gs.added or 0
              local removed = gs.removed or 0
              local result = ""
              if added > 0 then
                result = result .. "%#GitSignsAdd#" .. " " .. added .. "%* "
              end
              if removed > 0 then
                result = result .. "%#GitSignsDelete#" .. " " .. removed .. "%* "
              end
              return result
            end,
            padding = { left = 1, right = 1 },
          },
        },

        lualine_y = { "location" },
			  lualine_z = { "progress" },
      },
      options = {
        theme = 'auto',
        transparent = true,
        globalstatus = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "dashboard", "NvimTree" },
      }
    })
  end
}


