return {
	-- "tpope/vim-repeat",
	-- "tpope/vim-surround",
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{ -- File Browsing
		"prichrd/netrw.nvim",
		config = function()
			require("netrw").setup({
				-- Put your configuration here, or leave the object empty to take the default
				-- configuration.
				icons = {
					symlink = " ", -- Symlink icon (directory and file)
					directory = " ", -- Directory icon
					file = " ", -- File icon
				},
				use_devicons = true, -- Uses nvim-web-devicons if true, otherwise use the file icon specified above
				mappings = {}, -- Custom key mappings
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = {
					c = true,
					cpp = true,
					javascript = true,
					typescript = true,
					typescriptreact = true,
				}
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter is found.
			},
		},
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	{
		"mbbill/undotree",
		config = function()
			vim.g.undotree_ShortIndicators = 1
			vim.g.undotree_DiffAutoOpen = 0
			vim.g.undotree_TreeNodeShape = "•"
			vim.g.undotree_TreeReturnShape = "╲"
			vim.g.undotree_TreeVertShape = "│"
			vim.g.undotree_TreeSplitShape = "╱"

			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })
		end,
	},

	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {
			scope = {
				highlight = "@punctuation",
				show_start = false,
				show_end = false,
			},
		},
	},

	{
		"ThePrimeagen/99",
		config = function()
			local _99 = require("99")

			-- For logging that is to a file if you wish to trace through requests
			-- for reporting bugs, i would not rely on this, but instead the provided
			-- logging mechanisms within 99.  This is for more debugging purposes
			local cwd = vim.uv.cwd()
			local basename = vim.fs.basename(cwd)
			_99.setup({
				provider = _99.ClaudeCodeProvider, -- default: OpenCodeProvider
				logger = {
					level = _99.DEBUG,
					path = "/tmp/" .. basename .. ".99.debug",
					print_on_error = true,
				},

				--- Completions: #rules and @files in the prompt buffer
				completion = {
					-- I am going to disable these until i understand the
					-- problem better.  Inside of cursor rules there is also
					-- application rules, which means i need to apply these
					-- differently
					-- cursor_rules = "<custom path to cursor rules>"

					--- A list of folders where you have your own SKILL.md
					--- Expected format:
					--- /path/to/dir/<skill_name>/SKILL.md
					---
					--- Example:
					--- Input Path:
					--- "scratch/custom_rules/"
					---
					--- Output Rules:
					--- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
					--- ... the other rules in that dir ...
					---
					custom_rules = {
						"scratch/custom_rules/",
					},

					--- Configure @file completion (all fields optional, sensible defaults)
					files = {
						-- enabled = true,
						-- max_file_size = 102400,     -- bytes, skip files larger than this
						-- max_files = 5000,            -- cap on total discovered files
						-- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
					},

					--- What autocomplete do you use.  We currently only
					--- support cmp right now
					source = "cmp",
				},

				--- WARNING: if you change cwd then this is likely broken
				--- ill likely fix this in a later change
				---
				--- md_files is a list of files to look for and auto add based on the location
				--- of the originating request.  That means if you are at /foo/bar/baz.lua
				--- the system will automagically look for:
				--- /foo/bar/AGENT.md
				--- /foo/AGENT.md
				--- assuming that /foo is project root (based on cwd)
				md_files = {
					"AGENT.md",
				},
			})

			-- take extra note that i have visual selection only in v mode
			-- technically whatever your last visual selection is, will be used
			-- so i have this set to visual mode so i dont screw up and use an
			-- old visual selection
			--
			-- likely ill add a mode check and assert on required visual mode
			-- so just prepare for it now
			vim.keymap.set("v", "<leader>9v", function()
				_99.visual()
			end)

			--- if you have a request you dont want to make any changes, just cancel it
			vim.keymap.set("v", "<leader>9s", function()
				_99.stop_all_requests()
			end)
		end,
	},
}
