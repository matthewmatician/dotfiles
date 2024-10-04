return {
	{ -- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "warmer",
				code_style = {
					strings = "italic",
				},
				colors = {
					black = "#101012",
					bg_d = "#1b151b",
					bg0 = "#1f1c1a",
					bg1 = "#292722",
					bg2 = "#35322a",
					bg3 = "#37383d",
					grey = "#5a5b5e",
					light_grey = "#8F8375",
					fg = "#E8DBB7",

					bg_blue = "#68aee8",
					blue = "#66a2ff",

					purple = "#BD7EB4",
					dark_purple = "#79428a",

					green = "#B8BC47",
					orange = "#ED873A",

					bg_yellow = "#e2c792",
					yellow = "#F1BF50",
					dark_yellow = "#7c5c20",

					cyan = "#8AA499",
					dark_cyan = "#4b5d53",

					red = "#E75741",
					dark_red = "#833b3b",

					diff_add = "#262f24",
					diff_delete = "#302622",
					diff_change = "#1f2a34",
					diff_text = "#2c485f",
				},
				highlights = {
					["@keyword"] = { fg = "$red" },
					["@include"] = { fg = "$cyan" },
					["@operator"] = { fg = "$blue" },
					["@punctuation.bracket"] = { fg = "$orange" },
					["@punctuation.delimiter"] = { fg = "$blue" },
					["@tag"] = { fg = "$yellow" },
					["@tag.delimiter"] = { fg = "$orange" },
					["@tag.attribute"] = { fg = "$cyan", fmt = "italic" },
					["@type"] = { fg = "$fg" },
					["@function"] = { fg = "$fg" },
					Function = { fg = "$fg" },
					["@string"] = { fmt = "none" },
					["@property"] = { fg = "$cyan", fmt = "italic" },
					["@lsp.type.parameter"] = { fg = "$purple" },
					Search = { bg = "$bg3", fg = "none" },
					IncSearch = { bg = "$diff_text", fg = "none" },
					CurSearch = { bg = "$diff_text", fg = "none" },

					DiffDelete = { fg = "$dark_red" },
					Folded = { fg = "$light_grey", bg = "$bg0" },

					DiagnosticHint = { fg = "$cyan" },
					DiagnosticVirtualTextHint = { fg = "$dark_cyan", bg = "none", fmt = "italic" },
					DiagnosticVirtualTextError = { fg = "$dark_red", bg = "none", fmt = "italic" },
					DiagnosticVirtualTextWarn = { fg = "$dark_yellow", bg = "none", fmt = "italic" },

					TelescopeNormal = { bg = "$bg1" },
					TelescopePromptBorder = { bg = "$bg1", fg = "$grey" },
					TelescopePreviewBorder = { bg = "$bg1", fg = "$grey" },
					TelescopeResultsBorder = { bg = "$bg1", fg = "$grey" },
					FloatBorder = { bg = "$bg1", fg = "$grey" },
					NormalFloat = { bg = "$bg1" },

					NeoTreeNormal = { fg = "$fg", bg = "$bg0" },
					NeoTreeDirectoryName = { fg = "$light_grey" },
					NeoTreeDirectoryIcon = { fg = "$orange" },
					-- NeoTreeNormalNC = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
					-- NeoTreeVertSplit = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
					-- NeoTreeWinSeparator = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
					NeoTreeEndOfBuffer = { fg = "$bg3", bg = "$bg0" },
					NeoTreeRootName = { fg = "$purple", fmt = "bold" },
					NeoTreeGitAdded = { fg = "$green" },
					NeoTreeGitDeleted = { fg = "$red" },
					NeoTreeGitModified = { fg = "$yellow" },
					NeoTreeGitConflict = { fg = "$red", fmt = "bold,italic" },
					NeoTreeGitUntracked = { fg = "$red", fmt = "italic" },
					-- NeoTreeIndentMarker = colors.Grey,
					-- NeoTreeSymbolicLinkTarget = colors.Purple,
				},
			})
			vim.cmd.colorscheme("onedark")
		end,
	},

	{ -- show hex colors
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					names = false,
					rgb_fn = true,
					hsl_fn = true,
					mode = "virtualtext",
				},
			})
		end,
	},
}
