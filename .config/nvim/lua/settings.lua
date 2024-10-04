-- Searching & replacing
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- Editing Behavior
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.whichwrap = "b,s,h,l,<,>,[,]" -- backspace and cursor keys wrap too
vim.opt.hidden = true -- Hide buffers instead of closing them
vim.opt.confirm = true -- Confirm instead of failing when stuff's unsaved
vim.opt.updatetime = 250 -- When to show diagnostics and update git gutters
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect,noinsert" -- Set completeopt to have a better completion experience
vim.o.mouse = "a" -- Enable mouse mode
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.autochdir = false

-- Command-line completion
vim.o.wildmode = "longest:full,full"
-- vim.cmd("set wc=<C-n>") -- Can't use vim.o here because lua only accepts a number as an option
-- vim.o.wildmenu = true

-- Display
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 2
vim.opt.list = true
vim.opt.listchars = { tab = ",.", trail = ".", extends = "#", nbsp = "." }
vim.opt.diffopt = vim.opt.diffopt + "vertical"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.shortmess = vim.opt.shortmess + "a" -- Don't give |ins-completion-menu| messages.
vim.opt.signcolumn = "yes"
vim.o.number = true -- Make line numbers default
vim.o.breakindent = true -- Keep the indentation when wrapping happens
vim.opt.winwidth = 40
vim.opt.winminwidth = 8
vim.opt.winheight = 8
vim.opt.winminheight = 2
vim.o.showmode = false -- Don't show the mode. We already have it in the statusline
vim.opt.cursorline = true

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldnestmax = 200
vim.opt.foldlevel = 200

function _G.custom_fold_text()
	local line = vim.fn.getline(vim.v.foldstart)
	local line_count = vim.v.foldend - vim.v.foldstart + 1
	return " ⚡ " .. line .. ": " .. line_count .. " lines"
end

-- vim.opt.foldtext = 'v:lua.custom_fold_text()'
vim.opt.fillchars = { fold = "─", diff = " " }

-- Persistent views
vim.opt.viewoptions = "folds,cursor"
local save_fold = vim.api.nvim_create_augroup("Persistent Views", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "*.*",
	callback = function()
		vim.cmd.mkview()
	end,
	group = save_fold,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.*",
	callback = function()
		vim.cmd.loadview({ mods = { emsg_silent = true } })
	end,
	group = save_fold,
})

-- History
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- File Types
vim.filetype.add({ extension = { mdx = "mdx" } })

-- Sometimes I fat-finger the shift key and type `:Q` instead of `:q`
vim.api.nvim_create_user_command("Q", ":q", {})
vim.api.nvim_create_user_command("Qa", ":qa", {})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
