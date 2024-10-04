-- Fuzzy Finder (files, lsp, etc)
return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = true },
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			-- This will not install any breaking changes.
			-- For major updates, this must be adjusted manually.
			version = "^1.0.0",
		},
	},
	config = function()
		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
			pickers = {
				buffers = {
					mappings = {
						i = {
							["<c-x>"] = actions.delete_buffer + actions.move_selection_previous,
						},
						n = {
							x = actions.delete_buffer + actions.move_selection_previous,
						},
					},
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "live_grep_args")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>to", builtin.oldfiles, { desc = "[?] Find recently opened files" })
		vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "[ ] Find existing buffers" })

		-- vim.keymap.set('n', '<leader>/', function()
		--   -- You can pass additional configuration to telescope to change theme, layout, etc.
		--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		--     winblend = 10,
		--     previewer = false,
		--   })
		-- end, { desc = '[/] Fuzzily search in current buffer' })

		-- -- Telescope live_grep in git root
		-- -- Function to find the git root directory based on the current buffer's path
		-- local function find_git_root()
		--   -- Use the current buffer's path as the starting point for the git search
		--   local current_file = vim.api.nvim_buf_get_name(0)
		--   local current_dir
		--   local cwd = vim.fn.getcwd()
		--   -- If the buffer is not associated with a file, return nil
		--   if current_file == "" then
		--     current_dir = cwd
		--   else
		--     -- Extract the directory from the current file's path
		--     current_dir = vim.fn.fnamemodify(current_file, ":h")
		--   end
		--
		--   -- Find the Git root directory from the current file's path
		--   local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
		--   if vim.v.shell_error ~= 0 then
		--     print("Not a git repository. Searching on current working directory")
		--     return cwd
		--   end
		--   return git_root
		-- end
		--
		-- -- Custom live_grep function to search in git root
		-- local function live_grep_git_root()
		--   local git_root = find_git_root()
		--   if git_root then
		--     require('telescope.builtin').live_grep({
		--       search_dirs = { git_root },
		--     })
		--   end
		-- end
		--
		-- vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

		vim.keymap.set("n", "<leader>tg", builtin.git_files, { desc = "Search [G]it [F]iles" })
		vim.keymap.set("n", "<leader>o", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>th", builtin.help_tags, { desc = "[S]earch [H]elp" })
		-- vim.keymap.set('n', '<leader>s', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
		vim.keymap.set("n", "<leader>S", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		-- vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
		vim.keymap.set("n", "<leader>td", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>tr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set(
			"n",
			"<leader>s",
			require("telescope").extensions.live_grep_args.live_grep_args,
			{ desc = "Search by Grep (with rg args)" }
		)
		-- vim.keymap.set("n", "<leader>S", function()
		-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
		-- end, { desc = "Search by Grep and then through file names" })
	end,
}
