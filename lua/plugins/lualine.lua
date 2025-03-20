return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- for file icons
  },
  config = function()
    require('lualine').setup({
      sections = {
        lualine_a = {
          { "mode", separator = { right = ""}, right_padding = 0 },
        },
        lualine_b = {"branch"}, --"diff"
        lualine_c = {
            {"diagnostics", 
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn", "hint" },
            symbols = { error = " ", warn = " ", hint = " " },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
          function()
            local filename = vim.fn.expand("%:t")
            local ext = vim.fn.expand("%:e")
            local devicons = require("nvim-web-devicons")
            --local icon, _ = devicons.get_icon(filename, vim.bo.filetype, { default = true })
            local icon, icon_hl = devicons.get_icon(filename, ext, { default = true })
            if icon and icon_hl then
              icon = string.format("%%#%s#%s%%*", icon_hl, icon)
            end
            local relative = vim.fn.expand("%:.")
            local sep = package.config:sub(1,1)
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
              return icon .. "  " .. dir .. sep .. "%#LualineFileNameBold#" .. leaf .. "%*"
            else
              return icon .. "  " .. "%#LualineFileNameBold#" .. leaf .. "%*"
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
        lualine_y = {
          {
            function()
              local l = vim.fn.line(".")
              local total = vim.fn.line("$")
              local col = vim.fn.col(".")
              --local progress = math.floor((l / total) * 100)
              return string.format("%d:%d ", l, col)
            end,
          },
        },

        lualine_z = {
          {
            function()
              local l = vim.fn.line(".")
              local total = vim.fn.line("$")
              --local col = vim.fn.col(".")
              local progress = math.floor((l / total) * 100)
              return string.format("%d%%%% ", progress)
            end,
          },
        },
        --lualine_z = {
          --{
            --function()
              --return os.date("%H:%M")
            --end,
            --icon = "",  -- optional clock icon
          --}
        --},
      },
      options = {
        theme = 'auto',
        globalstatus = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "dashboard", "NvimTree" },
      } 
    })
  end
}
