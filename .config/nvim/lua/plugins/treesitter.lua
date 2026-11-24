-- Highlight, edit, and navigate code
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			-- The rewritten nvim-treesitter is a parser manager only.
			-- Highlighting and indentation are built into Neovim 0.11+.
			require("nvim-treesitter").install({
				"bash",
				"c",
				"cpp",
				"css",
				"go",
				"javascript",
				"lua",
				"python",
				"rust",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"styled",
			})

			-- Enable treesitter highlighting and indentation for all buffers
			-- that have an installed parser. (The old nvim-treesitter did this
			-- via highlight = { enable = true } / indent = { enable = true },
			-- but the rewrite is parser-management only.)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			vim.filetype.add({ extension = { mdx = "mdx" } })
			vim.treesitter.language.register("markdown", "mdx")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			local textobjects = require("nvim-treesitter-textobjects")
			textobjects.setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			-- Textobject selection keymaps
			local select = require("nvim-treesitter-textobjects.select")
			for lhs, capture in pairs({
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			}) do
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(capture)
				end, { desc = "Textobject: " .. capture })
			end

			-- Movement keymaps
			local move = require("nvim-treesitter-textobjects.move")
			local move_mappings = {
				["]m"] = { move.goto_next_start, "@function.outer" },
				["]]"] = { move.goto_next_start, "@class.outer" },
				["]M"] = { move.goto_next_end, "@function.outer" },
				["]["] = { move.goto_next_end, "@class.outer" },
				["[m"] = { move.goto_previous_start, "@function.outer" },
				["[["] = { move.goto_previous_start, "@class.outer" },
				["[M"] = { move.goto_previous_end, "@function.outer" },
				["[]"] = { move.goto_previous_end, "@class.outer" },
			}
			for lhs, mapping in pairs(move_mappings) do
				vim.keymap.set({ "n", "x", "o" }, lhs, function()
					mapping[1](mapping[2])
				end, { desc = "Move: " .. mapping[2] })
			end

			-- Swap keymaps
			local swap = require("nvim-treesitter-textobjects.swap")
			vim.keymap.set("n", "<leader>a", function()
				swap.swap_next("@parameter.inner")
			end, { desc = "Swap parameter forward" })
			vim.keymap.set("n", "<leader>A", function()
				swap.swap_previous("@parameter.inner")
			end, { desc = "Swap parameter backward" })
		end,
	},

	-- Automatically add closing tags for HTML and JSX
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {},
	},
}
