local c = {
	grey = "#5a5b5e",
	light_grey = "#8F8375",
	bg_blue = "#68aee8",
	blue = "#66a2ff",
	purple = "#BD7EB4",
	dark_purple = "#79428a",
	green = "#B8BC47",
	orange = "#ED873A",
	yellow = "#F1BF50",
	cyan = "#8AA499",
	dark_cyan = "#4b5d53",
	red = "#E75741",
	dark_red = "#833b3b",
}

local icons = {
	default = {
		icon = "", -- File icon
		color = c.dark_red,
		name = "default",
	},
	Dockerfile = {
		icon = "󰡨",
		color = c.blue,
		name = "Dockerfile",
	},
	R = {
		icon = "󰟔",
		color = c.blue,
		name = "R",
	},
	aac = {
		icon = "",
		color = c.blue,
		name = "Aac",
	},
	ai = {
		icon = "",
		color = c.yellow,
		name = "Ai",
	},
	applescript = {
		icon = "",
		color = c.cyan,
		name = "AppleScript",
	},
	awk = {
		icon = "",
		color = c.grey,
		name = "Awk",
	},
	azcli = {
		icon = "",
		color = c.blue,
		name = "AzureCli",
	},
	bash = {
		icon = "",
		color = c.green,
		name = "Bash",
	},
	bat = {
		icon = "",
		color = c.green,
		name = "Bat",
	},
	bazel = {
		icon = "",
		color = c.green,
		name = "Bazel",
	},
	bib = {
		icon = "󱉟",
		color = c.yellow,
		name = "BibTeX",
	},
	bmp = {
		icon = "",
		color = c.purple,
		name = "Bmp",
	},
	bzl = {
		icon = "",
		color = c.green,
		name = "Bzl",
	},
	c = {
		icon = "",
		color = c.blue,
		name = "C",
	},
	cbl = {
		icon = "⚙",
		color = c.blue,
		name = "Cobol",
	},
	cc = {
		icon = "",
		color = c.red,
		name = "CPlusPlus",
	},
	cfg = {
		icon = "",
		color = c.light_grey,
		name = "Configuration",
	},
	cjs = {
		icon = "",
		color = c.yellow,
		name = "Cjs",
	},
	clj = {
		icon = "",
		color = c.green,
		name = "Clojure",
	},
	cljc = {
		icon = "",
		color = c.green,
		name = "ClojureC",
	},
	cljs = {
		icon = "",
		color = c.blue,
		name = "ClojureJS",
	},
	cljd = {
		icon = "",
		color = c.blue,
		name = "ClojureDart",
	},
	cmake = {
		icon = "",
		color = c.grey,
		name = "CMake",
	},
	cob = {
		icon = "⚙",
		color = c.blue,
		name = "Cobol",
	},
	cobol = {
		icon = "⚙",
		color = c.blue,
		name = "Cobol",
	},
	coffee = {
		icon = "",
		color = c.yellow,
		name = "Coffee",
	},
	conf = {
		icon = "",
		color = c.grey,
		name = "Conf",
	},
	["config.ru"] = {
		icon = "",
		color = c.dark_red,
		name = "ConfigRu",
	},
	cp = {
		icon = "",
		color = c.blue,
		name = "Cp",
	},
	cpp = {
		icon = "",
		color = c.blue,
		name = "Cpp",
	},
	cpy = {
		icon = "⚙",
		color = c.blue,
		name = "Cobol",
	},
	cr = {
		icon = "",
		color = c.light_grey,
		name = "Crystal",
	},
	cs = {
		icon = "󰌛",
		color = c.green,
		name = "Cs",
	},
	csh = {
		icon = "",
		color = c.grey,
		name = "Csh",
	},
	cshtml = {
		icon = "󱦗",
		color = c.purple,
		name = "RazorPage",
	},
	cson = {
		icon = "",
		color = c.yellow,
		name = "Cson",
	},
	csproj = {
		icon = "󰪮",
		color = c.purple,
		name = "CSharpProject",
	},
	css = {
		icon = "",
		color = c.blue,
		name = "Css",
	},
	csv = {
		icon = "󰈙",
		color = c.green,
		name = "Csv",
	},
	cts = {
		icon = "",
		color = c.blue,
		name = "Cts",
	},
	cxx = {
		icon = "",
		color = c.blue,
		name = "Cxx",
	},
	d = {
		icon = "",
		color = c.green,
		name = "D",
	},
	dart = {
		icon = "",
		color = c.blue,
		name = "Dart",
	},
	db = {
		icon = "",
		color = c.light_grey,
		name = "Db",
	},
	desktop = {
		icon = "",
		color = c.dark_purple,
		name = "DesktopEntry",
	},
	diff = {
		icon = "",
		color = c.grey,
		name = "Diff",
	},
	doc = {
		icon = "󰈬",
		color = c.blue,
		name = "Doc",
	},
	docx = {
		icon = "󰈬",
		color = c.blue,
		name = "Docx",
	},
	drl = {
		icon = "",
		color = c.purple,
		name = "Drools",
	},
	dropbox = {
		icon = "",
		color = c.blue,
		name = "Dropbox",
	},
	dump = {
		icon = "",
		color = c.light_grey,
		name = "Dump",
	},
	edn = {
		icon = "",
		color = c.blue,
		name = "Edn",
	},
	eex = {
		icon = "",
		color = c.purple,
		name = "Eex",
	},
	ejs = {
		icon = "",
		color = c.yellow,
		name = "Ejs",
	},
	elm = {
		icon = "",
		color = c.blue,
		name = "Elm",
	},
	eot = {
		icon = "",
		color = c.light_grey,
		name = "EmbeddedOpenTypeFont",
	},
	epp = {
		icon = "",
		color = c.orange,
		name = "Epp",
	},
	erb = {
		icon = "",
		color = c.dark_red,
		name = "Erb",
	},
	erl = {
		icon = "",
		color = c.purple,
		name = "Erl",
	},
	ex = {
		icon = "",
		color = c.purple,
		name = "Ex",
	},
	exs = {
		icon = "",
		color = c.purple,
		name = "Exs",
	},
	["f#"] = {
		icon = "",
		color = c.blue,
		name = "Fsharp",
	},
	f90 = {
		icon = "󱈚",
		color = c.dark_purple,
		name = "Fortran",
	},
	flac = {
		icon = "",
		color = c.bg_blue,
		name = "Flac",
	},
	fnl = {
		icon = "🌜",
		color = c.light_grey,
		name = "Fennel",
	},
	fish = {
		icon = "",
		color = c.grey,
		name = "Fish",
	},
	fs = {
		icon = "",
		color = c.blue,
		name = "Fs",
	},
	fsi = {
		icon = "",
		color = c.blue,
		name = "Fsi",
	},
	fsscript = {
		icon = "",
		color = c.blue,
		name = "Fsscript",
	},
	fsx = {
		icon = "",
		color = c.blue,
		name = "Fsx",
	},
	gd = {
		icon = "",
		color = c.grey,
		name = "GDScript",
	},
	gemspec = {
		icon = "",
		color = c.dark_red,
		name = "Gemspec",
	},
	gif = {
		icon = "",
		color = c.purple,
		name = "Gif",
	},
	git = {
		icon = "",
		color = c.red,
		name = "GitLogo",
	},
	glb = {
		icon = "",
		color = c.yellow,
		name = "BinaryGLTF",
	},
	gnumakefile = {
		icon = "",
		color = c.grey,
		name = "Makefile",
	},
	go = {
		icon = "",
		color = c.blue,
		name = "Go",
	},
	godot = {
		icon = "",
		color = c.grey,
		name = "GodotProject",
	},
	gql = {
		icon = "",
		color = c.purple,
		name = "GraphQL",
	},
	graphql = {
		icon = "",
		color = c.purple,
		name = "GraphQL",
	},
	h = {
		icon = "",
		color = c.purple,
		name = "H",
	},
	haml = {
		icon = "",
		color = c.grey,
		name = "Haml",
	},
	hbs = {
		icon = "",
		color = c.orange,
		name = "Hbs",
	},
	heex = {
		icon = "",
		color = c.purple,
		name = "Heex",
	},
	hh = {
		icon = "",
		color = c.purple,
		name = "Hh",
	},
	hpp = {
		icon = "",
		color = c.purple,
		name = "Hpp",
	},
	hrl = {
		icon = "",
		color = c.dark_purple,
		name = "Hrl",
	},
	hs = {
		icon = "",
		color = c.purple,
		name = "Hs",
	},
	htm = {
		icon = "",
		color = c.red,
		name = "Htm",
	},
	html = {
		icon = "",
		color = c.red,
		name = "Html",
	},
	huff = {
		icon = "󰡘",
		color = c.blue,
		name = "Huff",
	},
	hurl = {
		icon = "",
		color = c.purple,
		name = "Hurl",
	},
	hxx = {
		icon = "",
		color = c.purple,
		name = "Hxx",
	},
	ico = {
		icon = "",
		color = c.yellow,
		name = "Ico",
	},
	import = {
		icon = "",
		color = c.light_grey,
		name = "ImportConfiguration",
	},
	ini = {
		icon = "",
		color = c.grey,
		name = "Ini",
	},
	java = {
		icon = "",
		color = c.dark_red,
		name = "Java",
	},
	jl = {
		icon = "",
		color = c.purple,
		name = "Jl",
	},
	jpeg = {
		icon = "",
		color = c.purple,
		name = "Jpeg",
	},
	jpg = {
		icon = "",
		color = c.purple,
		name = "Jpg",
	},
	js = {
		icon = "",
		color = c.red,
		name = "Js",
	},
	json = {
		icon = "",
		color = c.red,
		name = "Json",
	},
	json5 = {
		icon = "",
		color = c.red,
		name = "Json5",
	},
	jsonc = {
		icon = "",
		color = c.red,
		name = "Jsonc",
	},
	jsx = {
		icon = "",
		color = c.yellow,
		name = "Jsx",
	},
	jxl = {
		icon = "",
		color = c.purple,
		name = "JpegXl",
	},
	ksh = {
		icon = "",
		color = c.grey,
		name = "Ksh",
	},
	kt = {
		icon = "",
		color = c.dark_purple,
		name = "Kotlin",
	},
	kts = {
		icon = "",
		color = c.dark_purple,
		name = "KotlinScript",
	},
	leex = {
		icon = "",
		color = c.purple,
		name = "Leex",
	},
	less = {
		icon = "",
		color = c.dark_purple,
		name = "Less",
	},
	lhs = {
		icon = "",
		color = c.purple,
		name = "Lhs",
	},
	license = {
		icon = "",
		color = c.yellow,
		name = "License",
	},
	liquid = {
		icon = "",
		color = c.green,
		name = "Liquid",
	},
	lock = {
		icon = "",
		color = c.light_grey,
		name = "Lock",
	},
	log = {
		icon = "󰌱",
		color = c.light_grey,
		name = "Log",
	},
	lua = {
		icon = "",
		color = c.red,
		name = "Lua",
	},
	luau = {
		icon = "",
		color = c.red,
		name = "Luau",
	},
	m4a = {
		icon = "",
		color = c.bg_blue,
		name = "M4A",
	},
	m4v = {
		icon = "",
		color = c.orange,
		name = "M4V",
	},
	makefile = {
		icon = "",
		color = c.grey,
		name = "Makefile",
	},
	markdown = {
		icon = "",
		color = c.blue,
		name = "Markdown",
	},
	material = {
		icon = "󰔉",
		color = c.purple,
		name = "Material",
	},
	md = {
		icon = "",
		color = c.dark_purple,
		name = "Md",
	},
	mdx = {
		icon = "",
		color = c.purple,
		name = "Mdx",
	},
	mint = {
		icon = "󰌪",
		color = c.cyan,
		name = "Mint",
	},
	mjs = {
		icon = "",
		color = c.yellow,
		name = "Mjs",
	},
	mk = {
		icon = "",
		color = c.grey,
		name = "Makefile",
	},
	mkv = {
		icon = "",
		color = c.orange,
		name = "Mkv",
	},
	ml = {
		icon = "",
		color = c.orange,
		name = "Ml",
	},
	mli = {
		icon = "",
		color = c.orange,
		name = "Mli",
	},
	mo = {
		icon = "∞",
		color = c.purple,
		name = "Motoko",
	},
	mov = {
		icon = "",
		color = c.orange,
		name = "MOV",
	},
	mp3 = {
		icon = "",
		color = c.bg_blue,
		name = "Mp3",
	},
	mp4 = {
		icon = "",
		color = c.orange,
		name = "Mp4",
	},
	mts = {
		icon = "",
		color = c.blue,
		name = "Mts",
	},
	mustache = {
		icon = "",
		color = c.orange,
		name = "Mustache",
	},
	nim = {
		icon = "",
		color = c.yellow,
		name = "Nim",
	},
	nix = {
		icon = "",
		color = c.bg_blue,
		name = "Nix",
	},
	nswag = {
		icon = "",
		color = c.green,
		name = "Nswag",
	},
	ogg = {
		icon = "",
		color = c.bg_blue,
		name = "Ogg",
	},
	opus = {
		icon = "󰈣",
		color = c.orange,
		name = "OPUS",
	},
	org = {
		icon = "",
		color = c.cyan,
		name = "OrgMode",
	},
	otf = {
		icon = "",
		color = c.light_grey,
		name = "OpenTypeFont",
	},
	pck = {
		icon = "",
		color = c.grey,
		name = "PackedResource",
	},
	pdf = {
		icon = "",
		color = c.dark_red,
		name = "Pdf",
	},
	php = {
		icon = "",
		color = c.purple,
		name = "Php",
	},
	pl = {
		icon = "",
		color = c.blue,
		name = "Pl",
	},
	pm = {
		icon = "",
		color = c.blue,
		name = "Pm",
	},
	png = {
		icon = "",
		color = c.purple,
		name = "Png",
	},
	pp = {
		icon = "",
		color = c.orange,
		name = "Pp",
	},
	ppt = {
		icon = "󰈧",
		color = c.red,
		name = "Ppt",
	},
	prisma = {
		icon = "",
		color = c.light_grey,
		name = "Prisma",
	},
	pro = {
		icon = "",
		color = c.orange,
		name = "Prolog",
	},
	ps1 = {
		icon = "󰨊",
		color = c.blue,
		name = "PsScriptfile",
	},
	psd1 = {
		icon = "󰨊",
		color = c.dark_cyan,
		name = "PsManifestfile",
	},
	psm1 = {
		icon = "󰨊",
		color = c.dark_cyan,
		name = "PsScriptModulefile",
	},
	psb = {
		icon = "",
		color = c.blue,
		name = "Psb",
	},
	psd = {
		icon = "",
		color = c.blue,
		name = "Psd",
	},
	pxd = {
		icon = "",
		color = c.bg_blue,
		name = "Pxd",
	},
	pxi = {
		icon = "",
		color = c.bg_blue,
		name = "Pxi",
	},
	py = {
		icon = "",
		color = c.yellow,
		name = "Py",
	},
	pyc = {
		icon = "",
		color = c.light_grey,
		name = "Pyc",
	},
	pyd = {
		icon = "",
		color = c.light_grey,
		name = "Pyd",
	},
	pyi = {
		icon = "",
		color = c.yellow,
		name = "Pyi",
	},
	pyo = {
		icon = "",
		color = c.light_grey,
		name = "Pyo",
	},
	pyx = {
		icon = "",
		color = c.bg_blue,
		name = "Pyx",
	},
	query = {
		icon = "",
		color = c.green,
		name = "Query",
	},
	r = {
		icon = "󰟔",
		color = c.blue,
		name = "R",
	},
	rake = {
		icon = "",
		color = c.dark_red,
		name = "Rake",
	},
	razor = {
		icon = "󱦘",
		color = c.purple,
		name = "RazorPage",
	},
	rb = {
		icon = "",
		color = c.dark_red,
		name = "Rb",
	},
	res = {
		icon = "",
		color = c.red,
		name = "ReScript",
	},
	resi = {
		icon = "",
		color = c.purple,
		name = "ReScriptInterface",
	},
	rlib = {
		icon = "",
		color = c.purple,
		name = "Rlib",
	},
	rmd = {
		icon = "",
		color = c.blue,
		name = "Rmd",
	},
	rproj = {
		icon = "󰗆",
		color = c.green,
		name = "Rproj",
	},
	rs = {
		icon = "",
		color = c.purple,
		name = "Rs",
	},
	rss = {
		icon = "",
		color = c.orange,
		name = "Rss",
	},
	sass = {
		icon = "",
		color = c.purple,
		name = "Sass",
	},
	sbt = {
		icon = "",
		color = c.red,
		name = "sbt",
	},
	scala = {
		icon = "",
		color = c.red,
		name = "Scala",
	},
	scm = {
		icon = "󰘧",
		color = c.grey,
		name = "Scheme",
	},
	scss = {
		icon = "",
		color = c.purple,
		name = "Scss",
	},
	sh = {
		icon = "",
		color = c.grey,
		name = "Sh",
	},
	sig = {
		icon = "λ",
		color = c.orange,
		name = "Sig",
	},
	slim = {
		icon = "",
		color = c.red,
		name = "Slim",
	},
	sln = {
		icon = "",
		color = c.purple,
		name = "Sln",
	},
	sml = {
		icon = "λ",
		color = c.orange,
		name = "Sml",
	},
	sol = {
		icon = "",
		color = c.blue,
		name = "Solidity",
	},
	["spec.js"] = {
		icon = "",
		color = c.purple,
		name = "SpecJs",
	},
	["spec.jsx"] = {
		icon = "",
		color = c.purple,
		name = "JavaScriptReactSpec",
	},
	["spec.ts"] = {
		icon = "",
		color = c.purple,
		name = "SpecTs",
	},
	["spec.tsx"] = {
		icon = "",
		color = c.purple,
		name = "TypeScriptReactSpec",
	},
	sql = {
		icon = "",
		color = c.light_grey,
		name = "Sql",
	},
	sqlite = {
		icon = "",
		color = c.light_grey,
		name = "Sql",
	},
	sqlite3 = {
		icon = "",
		color = c.light_grey,
		name = "Sql",
	},
	styl = {
		icon = "",
		color = c.green,
		name = "Styl",
	},
	sublime = {
		icon = "",
		color = c.orange,
		name = "Suo",
	},
	suo = {
		icon = "",
		color = c.purple,
		name = "Suo",
	},
	sv = {
		icon = "󰍛",
		color = c.green,
		name = "SystemVerilog",
	},
	svelte = {
		icon = "",
		color = c.red,
		name = "Svelte",
	},
	svh = {
		icon = "󰍛",
		color = c.green,
		name = "SystemVerilog",
	},
	svg = {
		icon = "󰜡",
		color = c.yellow,
		name = "Svg",
	},
	swift = {
		icon = "",
		color = c.orange,
		name = "Swift",
	},
	t = {
		icon = "",
		color = c.blue,
		name = "Tor",
	},
	tbc = {
		icon = "󰛓",
		color = c.blue,
		name = "Tcl",
	},
	tcl = {
		icon = "󰛓",
		color = c.blue,
		name = "Tcl",
	},
	terminal = {
		icon = "",
		color = c.green,
		name = "Terminal",
	},
	["test.js"] = {
		icon = "",
		color = c.purple,
		name = "TestJs",
	},
	["test.jsx"] = {
		icon = "",
		color = c.purple,
		name = "JavaScriptReactTest",
	},
	["test.ts"] = {
		icon = "",
		color = c.purple,
		name = "TestTs",
	},
	["test.tsx"] = {
		icon = "",
		color = c.purple,
		name = "TypeScriptReactTest",
	},
	tex = {
		icon = "󰙩",
		color = c.green,
		name = "Tex",
	},
	tf = {
		icon = "",
		color = c.purple,
		name = "Terraform",
	},
	tfvars = {
		icon = "",
		color = c.purple,
		name = "TFVars",
	},
	toml = {
		icon = "",
		color = c.grey,
		name = "Toml",
	},
	tres = {
		icon = "",
		color = c.yellow,
		name = "TextResource",
	},
	ts = {
		icon = "",
		color = c.blue,
		name = "Ts",
	},
	tscn = {
		icon = "󰎁",
		color = c.purple,
		name = "TextScene",
	},
	tsx = {
		icon = "",
		color = c.blue,
		name = "Tsx",
	},
	ttf = {
		icon = "",
		color = c.light_grey,
		name = "TrueTypeFont",
	},
	twig = {
		icon = "",
		color = c.green,
		name = "Twig",
	},
	txt = {
		icon = "󰈙",
		color = c.green,
		name = "Txt",
	},
	v = {
		icon = "󰍛",
		color = c.green,
		name = "Verilog",
	},
	vala = {
		icon = "",
		color = c.dark_purple,
		name = "Vala",
	},
	vh = {
		icon = "󰍛",
		color = c.green,
		name = "Verilog",
	},
	vhd = {
		icon = "󰍛",
		color = c.green,
		name = "VHDL",
	},
	vhdl = {
		icon = "󰍛",
		color = c.green,
		name = "VHDL",
	},
	vim = {
		icon = "",
		color = c.green,
		name = "Vim",
	},
	vsh = {
		icon = "",
		color = c.bg_blue,
		name = "Vlang",
	},
	vue = {
		icon = "",
		color = c.green,
		name = "Vue",
	},
	wav = {
		icon = "",
		color = c.bg_blue,
		name = "Wav",
	},
	webm = {
		icon = "",
		color = c.orange,
		name = "Webm",
	},
	webmanifest = {
		icon = "",
		color = c.yellow,
		name = "Webmanifest",
	},
	webp = {
		icon = "",
		color = c.purple,
		name = "Webp",
	},
	webpack = {
		icon = "󰜫",
		color = c.blue,
		name = "Webpack",
	},
	woff = {
		icon = "",
		color = c.light_grey,
		name = "WebOpenFontFormat",
	},
	woff2 = {
		icon = "",
		color = c.light_grey,
		name = "WebOpenFontFormat",
	},
	xaml = {
		icon = "󰙳",
		color = c.purple,
		name = "Xaml",
	},
	xcplayground = {
		icon = "",
		color = c.orange,
		name = "XcPlayground",
	},
	xls = {
		icon = "󰈛",
		color = c.dark_cyan,
		name = "Xls",
	},
	xlsx = {
		icon = "󰈛",
		color = c.dark_cyan,
		name = "Xlsx",
	},
	xml = {
		icon = "󰗀",
		color = c.orange,
		name = "Xml",
	},
	xul = {
		icon = "",
		color = c.orange,
		name = "Xul",
	},
	yaml = {
		icon = "",
		color = c.grey,
		name = "Yaml",
	},
	yml = {
		icon = "",
		color = c.red,
		name = "Yml",
	},
	zig = {
		icon = "",
		color = c.orange,
		name = "Zig",
	},
	zsh = {
		icon = "",
		color = c.green,
		name = "Zsh",
	},
	wasm = {
		icon = "",
		color = c.dark_purple,
		name = "Wasm",
	},
}

return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-web-devicons").setup({
			-- your personnal icons can go here (to override)
			-- you can specify color or cterm_color instead of specifying both of them
			-- DevIcon will be appended to `name`
			override = icons,

			-- globally enable different highlight colors per icon (default to true)
			-- if set to false all icons will have the default icon's color
			color_icons = true,

			-- globally enable default icons (default to false)
			-- will get overriden by `get_icons` option
			-- default = true;

			-- globally enable "strict" selection of icons - icon will be looked up in
			-- different tables, first by filename, and if not found by extension; this
			-- prevents cases when file doesn't have any extension but still gets some icon
			-- because its name happened to match some extension (default to false)
			strict = true,

			-- same as `override` but specifically for overrides by filename
			-- takes effect when `strict` is true
			override_by_filename = {
				[".gitignore"] = {
					icon = "",
					color = "#f1502f",
					name = "Gitignore",
				},
			},

			-- same as `override` but specifically for overrides by extension
			-- takes effect when `strict` is true
			override_by_extension = {
				["log"] = {
					icon = "",
					color = "#81e043",
					name = "Log",
				},
				["js"] = {
					icon = "",
					color = c.yellow,
					name = "Js",
				},
				["jsx"] = {
					icon = "",
					color = c.yellow,
					name = "JavascriptReact",
				},
				["ts"] = {
					icon = "󰛦",
					color = c.blue,
					name = "Ts",
				},
				["tsx"] = {
					icon = "󰛦",
					color = c.blue,
					name = "TypescriptReact",
				},
				["cy.js"] = {
					icon = "",
					color = c.purple,
					name = "SpecJs",
				},
				["cy.jsx"] = {
					icon = "",
					color = c.purple,
					name = "JavaScriptReactSpec",
				},
				["cy.ts"] = {
					icon = "",
					color = c.purple,
					name = "SpecTs",
				},
				["cy.tsx"] = {
					icon = "",
					color = c.purple,
					name = "TypeScriptReactSpec",
				},
			},
		})
	end,
}
