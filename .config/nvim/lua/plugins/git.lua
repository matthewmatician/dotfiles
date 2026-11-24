local function g_browse_smart()
	local file = vim.fn.expand("%")
	if file == "" then
		print("No file to browse")
		return
	end

	-- Get git root
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if not git_root or git_root == "" then
		print("Not in a git repository")
		return
	end

	local line_num = vim.fn.line(".")

	-- Get current branch
	local branch = vim.fn.systemlist("git symbolic-ref --short HEAD 2>/dev/null")[1]

	-- Find upstream to compare against
	local upstream = nil
	if branch and branch ~= "" then
		upstream = vim.fn.systemlist("git rev-parse --abbrev-ref " .. branch .. "@{u} 2>/dev/null")[1]
	end

	-- If no upstream, try origin/main or origin/master
	if not upstream or upstream == "" then
		local main_exists = vim.fn.systemlist("git rev-parse --verify origin/main 2>/dev/null")[1]
		if main_exists and main_exists ~= "" then
			upstream = "origin/main"
		else
			local master_exists = vim.fn.systemlist("git rev-parse --verify origin/master 2>/dev/null")[1]
			if master_exists and master_exists ~= "" then
				upstream = "origin/master"
			end
		end
	end

	if not upstream or upstream == "" then
		print("No remote branch found")
		return
	end

	-- Find merge-base (closest common ancestor with remote)
	local merge_base = vim.fn.systemlist("git merge-base HEAD " .. upstream .. " 2>/dev/null")[1]
	if not merge_base or merge_base == "" then
		print("Could not find merge base")
		return
	end

	-- Use the merge-base commit with line number
	vim.cmd(line_num .. "GBrowse " .. merge_base .. ":%")
end

local function g_diff_toggle()
	-- If not in diff mode → open diff normally
	if not vim.wo.diff then
		vim.cmd("Gdiffsplit")
		return
	end

	local cur_win = vim.api.nvim_get_current_win()
	local cur_buf = vim.api.nvim_get_current_buf()

	-- Helper: identify Fugitive
	local function is_fugitive_buffer(buf)
		local name = vim.api.nvim_buf_get_name(buf)
		return name:match("^fugitive://")
	end

	----------------------------------------------------------
	-- Step 1: Find all windows participating in the current diff
	----------------------------------------------------------
	local all_wins = vim.api.nvim_tabpage_list_wins(0)
	local diff_wins = {}
	for _, win in ipairs(all_wins) do
		if vim.wo[win].diff then
			table.insert(diff_wins, win)
		end
	end

	if #diff_wins == 0 then
		return -- nothing to do
	end

	----------------------------------------------------------
	-- Step 2: Decide which window survives (the working tree)
	----------------------------------------------------------
	local survivor_win = cur_win
	for _, win in ipairs(diff_wins) do
		local buf = vim.api.nvim_win_get_buf(win)
		if not is_fugitive_buffer(buf) then
			survivor_win = win
			break
		end
	end

	----------------------------------------------------------
	-- Step 3: Turn off diff in all participating windows
	----------------------------------------------------------
	vim.cmd("diffoff!")

	----------------------------------------------------------
	-- Step 4: Close the windows that should die (all except survivor)
	----------------------------------------------------------
	for _, win in ipairs(diff_wins) do
		if win ~= survivor_win and vim.api.nvim_win_is_valid(win) then
			local buf = vim.api.nvim_win_get_buf(win)

			-- Close the window
			vim.api.nvim_win_close(win, true)

			-- Step 5: Delete Fugitive buffers only
			if is_fugitive_buffer(buf) and vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end
end

-- Module-level state for fugitive floating window
local fugitive_status_buf = nil
local fugitive_cursor_pos = nil

-- Helper: Create centered floating window
local function create_centered_float(bufnr)
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local win = vim.api.nvim_open_win(bufnr, true, {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	})

	-- Set window-local options for minimal style
	vim.wo[win].number = false
	vim.wo[win].relativenumber = false
	vim.wo[win].signcolumn = "no"

	return win
end

-- Main: Toggle git status in floating window
local function git_window_toggle()
	-- If we're already in the fugitive buffer, close the window (toggle off)
	if
		fugitive_status_buf
		and vim.api.nvim_buf_is_valid(fugitive_status_buf)
		and vim.api.nvim_get_current_buf() == fugitive_status_buf
	then
		-- Save cursor position before closing
		fugitive_cursor_pos = vim.api.nvim_win_get_cursor(0)
		vim.api.nvim_win_close(0, false)
		return
	end

	-- Check if we have a valid fugitive buffer stored
	if not fugitive_status_buf or not vim.api.nvim_buf_is_valid(fugitive_status_buf) then
		-- Create new Git status buffer (opens in current window)
		vim.cmd("Git")
		fugitive_status_buf = vim.api.nvim_get_current_buf()

		-- Create floating window with fugitive buffer
		create_centered_float(fugitive_status_buf)

		-- Close all non-floating windows showing the fugitive buffer
		local wins = vim.api.nvim_list_wins()
		local non_float_wins_to_close = {}

		for _, win in ipairs(wins) do
			if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == fugitive_status_buf then
				local config = vim.api.nvim_win_get_config(win)
				-- Only close non-floating windows (relative == "")
				if config.relative == "" then
					table.insert(non_float_wins_to_close, win)
				end
			end
		end

		-- Close the windows (with protection against closing last window)
		for _, win in ipairs(non_float_wins_to_close) do
			if vim.api.nvim_win_is_valid(win) then
				pcall(vim.api.nvim_win_close, win, false)
			end
		end

		return
	end

	-- Create floating window with the existing buffer
	create_centered_float(fugitive_status_buf)

	-- Restore cursor position if we have one saved
	if fugitive_cursor_pos then
		-- Validate the position is within buffer bounds
		local line_count = vim.api.nvim_buf_line_count(fugitive_status_buf)
		local row = math.min(fugitive_cursor_pos[1], line_count)
		pcall(vim.api.nvim_win_set_cursor, 0, { row, fugitive_cursor_pos[2] })
	end
end

-- Set up autocommands for floating window management
local augroup = vim.api.nvim_create_augroup("GitFloatWindow", { clear = true })

-- FileType autocommand: Add Escape keymap for fugitive buffers
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "fugitive",
	callback = function(args)
		local bufname = vim.api.nvim_buf_get_name(args.buf)
		if bufname:match("^fugitive://") then
			vim.keymap.set("n", "<Esc>", function()
				-- Save cursor position if this is the status buffer
				if args.buf == fugitive_status_buf then
					fugitive_cursor_pos = vim.api.nvim_win_get_cursor(0)
				end
				vim.api.nvim_win_close(0, false)
			end, { buffer = args.buf, desc = "Close fugitive window" })
		end
	end,
})

-- BufLeave autocommand: Close floating windows when leaving fugitive status buffer
vim.api.nvim_create_autocmd("BufLeave", {
	group = augroup,
	pattern = "fugitive://*",
	callback = function(args)
		-- Only handle the git status buffer, not diff buffers
		if args.buf ~= fugitive_status_buf then
			return
		end

		-- Save cursor position before leaving
		local current_win = vim.api.nvim_get_current_win()
		if vim.api.nvim_win_is_valid(current_win) then
			fugitive_cursor_pos = vim.api.nvim_win_get_cursor(current_win)
		end

		-- Find and close floating windows showing this buffer
		local wins = vim.api.nvim_list_wins()
		for _, win in ipairs(wins) do
			if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == args.buf then
				local config = vim.api.nvim_win_get_config(win)
				-- Only close floating windows (relative ~= "")
				if config.relative ~= "" then
					vim.api.nvim_win_close(win, false)
				end
			end
		end
	end,
})

-- BufDelete autocommand: Reset state when buffer is deleted
vim.api.nvim_create_autocmd("BufDelete", {
	group = augroup,
	pattern = "fugitive://*",
	callback = function(args)
		if args.buf == fugitive_status_buf then
			fugitive_status_buf = nil
			fugitive_cursor_pos = nil
		end
	end,
})

return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>g", git_window_toggle, { desc = "Toggle [G]it Files" })
			vim.keymap.set("n", "<leader>d", g_diff_toggle, { desc = "Toggle vsplit diff with committed version" })
			vim.keymap.set("n", "<leader>B", g_browse_smart, { desc = "Open file in a web Browser" })

			vim.api.nvim_create_user_command("GbrowseSmart", g_browse_smart, {})
			vim.api.nvim_create_user_command("GdiffToggle", g_diff_toggle, {})
		end,
	},

	"tpope/vim-rhubarb",

	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "│" },
			},
			on_attach = function(bufnr)
				vim.keymap.set(
					"n",
					"<leader>hp",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "Preview git hunk" }
				)

				-- don't override the built-in and fugitive keymaps
				local gs = package.loaded.gitsigns
				vim.keymap.set({ "n", "v" }, "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
				vim.keymap.set({ "n", "v" }, "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
			end,
		},
	},
}
