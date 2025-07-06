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
              return icon .. " " .. "%#LualineDir#" .. dir .. "%*" .. sep .. "%#LualineFileNameBold#" .. leaf .. "%*"
              --return icon .. "  " .. dir .. sep .. "%#LualineFileNameBold#" .. leaf .. "%*"
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

        lualine_y = { "location" },
			  lualine_z = { "progress" },
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


-- lua/plugins/lualine.lua
-- return {
--   "nvim-lualine/lualine.nvim",
--   opts = function(plugin, opts)
--     -- This function gets the default LazyVim `opts` and lets us modify them
--
--     -- 1. START by inserting your custom components where you want them
--     -- Add your custom filename function to lualine_c
--     table.insert(opts.sections.lualine_c, {
--       -- Your custom filename display function
--       function()
--         local filename = vim.fn.expand("%:t")
--         local ext = vim.fn.expand("%:e")
--         local devicons = require("nvim-web-devicons")
--         local icon, icon_hl = devicons.get_icon(filename, ext, { default = true })
--         if icon and icon_hl then
--           icon = string.format("%%#%s#%s%%*", icon_hl, icon)
--         end
--         local relative = vim.fn.expand("%:.")
--         local sep = package.config:sub(1, 1)
--         local parts = {}
--         for part in string.gmatch(relative, "[^" .. sep .. "]+") do
--           table.insert(parts, part)
--         end
--         if #parts == 0 then
--           return icon .. "  " .. relative
--         end
--         local leaf = parts[#parts]
--         local dir = (#parts > 1) and table.concat(parts, sep, 1, #parts - 1) or ""
--         if dir ~= "" then
--           return icon .. " " .. "%#LualineDir#" .. dir .. "%*" .. sep .. "%#LualineFileNameBold#" .. leaf .. "%*"
--         else
--           return icon .. "  " .. "%#LualineFileNameBold#" .. leaf .. "%*"
--         end
--       end,
--     })
--
--     -- Add your custom gitsigns function to lualine_x
--     table.insert(opts.sections.lualine_x, 1, {
--       function()
--         local gs = vim.b.gitsigns_status_dict or {}
--         local added = gs.added or 0
--         local removed = gs.removed or 0
--         local result = ""
--         if added > 0 then
--           result = result .. "%#GitSignsAdd#" .. " " .. added .. "%* "
--         end
--         if removed > 0 then
--           result = result .. "%#GitSignsDelete#" .. " " .. removed .. "%* "
--         end
--         return result
--       end,
--     })
--
--     -- 2. THEN, we ensure the default code context component from Trouble is added
--     -- This block is copied directly from the LazyVim default config
--     if LazyVim.has("trouble.nvim") then
--       local trouble = require("trouble")
--       local symbols = trouble.statusline({
--         mode = "symbols",
--         groups = {},
--         title = false,
--         filter = { range = true },
--         format = "{kind_icon}{symbol.name:Normal}",
--         hl_group = "lualine_c_normal",
--       })
--       table.insert(opts.sections.lualine_c, 1, { -- Insert as the first item in section C
--         symbols.get,
--         cond = function()
--           return vim.b.trouble_lualine ~= false and symbols.has()
--         end,
--       })
--     end
--
--     -- 3. FINALLY, apply your separator style overrides
--     opts.options.component_separators = { left = "", right = "" }
--     opts.options.section_separators = { left = "", right = "" }
--
--     -- Return the fully modified options table
--     return opts
--   end,
-- }



-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	-- We add nvim-navic as a dependency for the code context feature
-- 	dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
-- 	opts = {
-- 		options = {
-- 			theme = "auto",
-- 			globalstatus = true,
-- 			section_separators = { left = "", right = "" },
-- 			component_separators = { left = "", right = "" },
-- 			disabled_filetypes = { statusline = { "alpha", "dashboard", "NvimTree" } },
-- 		},
-- 		sections = {
-- 			lualine_a = {
-- 				{ "mode", separator = { right = "" }, right_padding = 0 },
-- 			},
-- 			lualine_b = { "branch" },
-- 			lualine_c = {
-- 				LazyVim.lualine.root_dir(),
-- 				{
-- 					"diagnostics",
-- 					symbols = {
-- 						error = icons.diagnostics.Error,
-- 						warn = icons.diagnostics.Warn,
-- 						info = icons.diagnostics.Info,
-- 						hint = icons.diagnostics.Hint,
-- 					},
-- 				},
-- 				{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
-- 				{ LazyVim.lualine.pretty_path() },
-- 			},
--
-- 			-- lualine_c = {
-- 			--   -- Here is the component that shows the function/struct name
-- 			--   {
-- 			--     "navic",
-- 			--     -- This avoids showing "file" icon next to the navic component
-- 			--     show_icons = false,
-- 			--   },
-- 			--   -- This is your custom filename function from your old config
-- 			--   function()
-- 			--     local filename = vim.fn.expand("%:t")
-- 			--     local ext = vim.fn.expand("%:e")
-- 			--     local devicons = require("nvim-web-devicons")
-- 			--     local icon, icon_hl = devicons.get_icon(filename, ext, { default = true })
-- 			--     if icon and icon_hl then
-- 			--       icon = string.format("%%#%s#%s%%*", icon_hl, icon)
-- 			--     end
-- 			--     local relative = vim.fn.expand("%:.")
-- 			--     local sep = package.config:sub(1, 1)
-- 			--     local parts = {}
-- 			--     for part in string.gmatch(relative, "[^" .. sep .. "]+") do
-- 			--       table.insert(parts, part)
-- 			--     end
-- 			--     if #parts == 0 then
-- 			--       return icon .. "  " .. relative
-- 			--     end
-- 			--     local leaf = parts[#parts]
-- 			--     local dir = (#parts > 1) and table.concat(parts, sep, 1, #parts - 1) or ""
-- 			--     if dir ~= "" then
-- 			--       return icon .. " " .. "%#LualineDir#" .. dir .. "%*" .. sep .. "%#LualineFileNameBold#" .. leaf .. "%*"
-- 			--     else
-- 			--       return icon .. "  " .. "%#LualineFileNameBold#" .. leaf .. "%*"
-- 			--     end
-- 			--   end,
-- 			-- },
-- 			lualine_x = {
-- 				{ "diagnostics", symbols = { error = " ", warn = " ", hint = " " } },
-- 				-- This is your custom gitsigns function
-- 				{
-- 					function()
-- 						local gs = vim.b.gitsigns_status_dict or {}
-- 						local added = gs.added or 0
-- 						local removed = gs.removed or 0
-- 						local result = ""
-- 						if added > 0 then
-- 							result = result .. "%#GitSignsAdd#" .. " " .. added .. "%* "
-- 						end
-- 						if removed > 0 then
-- 							result = result .. "%#GitSignsDelete#" .. " " .. removed .. "%* "
-- 						end
-- 						return result
-- 					end,
-- 					padding = { left = 1, right = 1 },
-- 				},
-- 			},
-- 			-- lualine_y = {
-- 			--   {
-- 			--     function()
-- 			--       local l = vim.fn.line(".")
-- 			--       local total = vim.fn.line("$")
-- 			--       local col = vim.fn.col(".")
-- 			--       --local progress = math.floor((l / total) * 100)
-- 			--       return string.format("%d:%d ", l, col)
-- 			--     end,
-- 			--   },
-- 			-- },
-- 			-- lualine_z = {
-- 			--   {
-- 			--     function()
-- 			--       local l = vim.fn.line(".")
-- 			--       local total = vim.fn.line("$")
-- 			--       --local col = vim.fn.col(".")
-- 			--       local progress = math.floor((l / total) * 100)
-- 			--       return string.format("%d%%%% ", progress)
-- 			--     end,
-- 			--   },
-- 			-- },
-- 			lualine_y = { "location" },
-- 			lualine_z = { "progress" },
-- 			-- lualine_z = { "location", separator = { left = "" }, left_padding = 2 },
-- 		},
-- 	},
-- }

