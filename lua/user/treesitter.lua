local status_ok_1 = pcall(require, "nvim-treesitter")
if not status_ok_1 then
	return
end
require("nvim-treesitter.install").prefer_git = true

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "tsx", "typescript", "javascript" }, -- put the language you want in this array
	-- ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	auto_install = true,
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

	modules = {},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
