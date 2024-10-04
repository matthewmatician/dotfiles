local modeAbrevs = {
	COMMAND = "C",
	NORMAL = "N",
	INSERT = "I",
	REPLACE = "R",
	VISUAL = "V",
	["V-LINE"] = "VL",
	["V-BLOCK"] = "VB",
}

local shortenMode = function(str)
	local found = modeAbrevs[str]
	if found then
		return found
	else
		return str
	end
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	opts = {
		options = {
			icons_enabled = true,
			theme = "onedark",
			component_separators = "|",
			always_divide_middle = false,
		},
		sections = {
			lualine_a = { { "mode", fmt = shortenMode } },
			lualine_b = { "branch", "diagnostics" },
			lualine_c = { { "filename", path = 1, symbols = { modified = "★" } } },
			lualine_x = { { "searchcount" }, { "filetype", icon_only = true, colored = true } },
		},
	},
}
