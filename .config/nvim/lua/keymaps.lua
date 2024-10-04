-- This keymap is just here to show the keymap info window
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Open the current folder in netrw
vim.keymap.set("n", "<leader>-", ":e %:p:h<cr>", { desc = "Open folder of current file." })

-- Easier moving in windows
vim.keymap.set("", "<leader>j", "<C-W>j", { desc = "Move down a window" })
vim.keymap.set("", "<leader>k", "<C-W>k", { desc = "Move up a window" })
vim.keymap.set("", "<leader>l", "<C-W>l", { desc = "Move right a window" })
vim.keymap.set("", "<leader>h", "<C-W>h", { desc = "Move left a window" })

-- Easier resizing in windows
vim.keymap.set("", "<leader>H", "<C-W>16<", { desc = "Shrink window width" })
vim.keymap.set("", "<leader>L", "<C-W>16>", { desc = "Grow window width" })
vim.keymap.set("", "<leader>J", ":res +5<cr>", { desc = "Grow window height" })
vim.keymap.set("", "<leader>K", ":res -5<cr>", { desc = "Shrink window height" })
vim.keymap.set("", "<leader>=", "<c-w>=", { desc = "Make windows all the same size" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Yank to clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = "Yank rest of line to clipboard" })
vim.keymap.set("x", "<leader>y", '"+y', { desc = "Yank to clipboard" })

-- Cut to clipboard
vim.keymap.set("n", "<leader>x", '"+x', { desc = "Cut to clipboard" })
vim.keymap.set("n", "<leader>X", '"+x$', { desc = "Cut rest of line to clipboard" })
vim.keymap.set("x", "<leader>x", '"+x', { desc = "Cut to clipboard" })

-- Paste w/o overriding the zero register
vim.keymap.set("x", "p", '"_dP')

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste-after from clipboard" })
vim.keymap.set("x", "<leader>p", '"_d"+P', { desc = "Paste from clipboard" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN } })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.WARN } })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>E", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

--  Movin lines of code around - Visual
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")

-- Inspecting highlights
vim.keymap.set("n", "<leader>I", vim.cmd.Inspect, { desc = "Inspect Hilight Group under Cursor" })

-- Stop showing search highlights
vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch, { desc = "Turn off search highlights" })

-- Better way to escape terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Close a buffer, but keep the window
-- TODO: Make this a plugin someday

-- Get the list of buffers (minus buffers that aren't valid or listed)
local getBufferList = function()
	return vim.tbl_filter(function(buf)
		return vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted")
	end, vim.api.nvim_list_bufs())
end

local killDumBuffers = function()
	for _, buf in ipairs(getBufferList()) do
		if
			vim.fn.bufwinnr(buf) == -1
			and (
				string.len(vim.fn.getbufvar(buf, "&filetype")) == 0
				or vim.fn.stridx(vim.fn.bufname(buf), "/^fugitive:/") == 0
			)
		then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

local closeBufferKeepWindow = function()
	local buffToDelete = vim.api.nvim_win_get_buf(0)
	local newBuffer = vim.fn.bufnr("#")

	-- Load the next buffer
	if newBuffer ~= -1 and newBuffer ~= buffToDelete and vim.fn.buflisted(newBuffer) then
		vim.api.nvim_win_set_buf(0, newBuffer)
	else
		vim.cmd.bnext()
	end

	-- Delete the Previous Buffer
	if string.len(vim.fn.bufname(buffToDelete)) > 0 then
		vim.api.nvim_buf_delete(buffToDelete, {})
	else
		print(buffToDelete .. " does not exist.")
	end

	killDumBuffers()
end

-- vim.api.nvim_create_user_command('KillDumBuffers', killDumBuffers, {})
-- vim.api.nvim_create_user_command('KeepSplitClose', keepSplitClose, {})
vim.keymap.set("n", "<leader>w", closeBufferKeepWindow, { desc = "Close buffer, keep window." })

--autocmd WinClosed * :call KillDumBuffers()
local killDum_group = vim.api.nvim_create_augroup("KillDumBuffers", { clear = true })
vim.api.nvim_create_autocmd("WinClosed", {
	callback = killDumBuffers,
	group = killDum_group,
	pattern = "*",
})

-- use eslint to format javascript
vim.api.nvim_create_autocmd("BufWritePre", {
	command = "silent! EslintFixAll",
	group = vim.api.nvim_create_augroup("JavascriptFormattings", {}),
	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
})
