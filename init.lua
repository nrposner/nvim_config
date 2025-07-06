vim.lsp.get_active_clients = vim.lsp.get_clients

vim.g.mapleader = " "
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("abb teh the")
vim.cmd("abb hte the")
vim.cmd("abb tostr to_string")
vim.cmd("abb tostr() to_string()")
vim.cmd("abb -- ->")
vim.cmd([[highlight LualineFileNameBold gui=bold]])
vim.cmd([[highlight LualineDir guifg=#808080]])

vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", {})

vim.keymap.set("n", "<leader>n", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>p", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename Symbol" })
vim.keymap.set("n", "<leader>jl", "ggVG", { desc = "Select entire file" })

-- vim.keymap.set('n', 'U', '<C-r>')

vim.opt.number = true
vim.opt.wrap = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("FileType", {
	pattern = "Avante",
	callback = function()
		vim.keymap.set("n", "ca", function()
			require("avante.ui.buffer").accept_all()
		end, { buffer = true, desc = "Avante: Accept all suggestions" })
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- require("config.lazy")

require("lazy").setup("plugins")

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>hh", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hi", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>hj", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>hk", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>hl", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>h;", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>ha", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>hf", function() harpoon:list():next() end)

-- Map two consecutive hs to Escape in Insert mode
-- vim.keymap.set('i', 'hh', '<Esc>', { noremap = true, silent = true })
