-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	{ "nvim-lua/plenary.nvim" },
	{ "ThePrimeagen/harpoon" },
	{ "windwp/nvim-autopairs" },
	{ "windwp/nvim-ts-autotag" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-obsession" },
	{ "ggandor/leap.nvim" },
	{ "numToStr/Comment.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{ "akinsho/bufferline.nvim" },
	{ "moll/vim-bbye" },
	{ "nvim-lualine/lualine.nvim" },
	{ "akinsho/toggleterm.nvim" },
	{ "ahmedkhalf/project.nvim" },
	{ "lewis6991/impatient.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "goolord/alpha-nvim" },
	{ "folke/which-key.nvim" },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{ "dracula/vim", name = "dracula" },
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},

	-- cmp plugins
	{ "hrsh7th/nvim-cmp" }, -- The completion plugin
	{ "hrsh7th/cmp-buffer" }, -- buffer completions
	{ "hrsh7th/cmp-path" }, -- path completions
	{ "saadparwaiz1/cmp_luasnip" }, -- snippet completions
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "onsails/lspkind-nvim" },

	-- snippets
	{
		--snippet engine
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{ "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

	-- LSP
	{ "neovim/nvim-lspconfig", dependencies = { "nvimdev/lspsaga.nvim" } }, -- enable LSP
	{ "williamboman/mason.nvim", build = ":MasonUpdate" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
	},
	-- automatically highlighting other uses of the word under the cursor
	{ "RRethy/vim-illuminate" },

	-- Telescope
	{ "nvim-telescope/telescope.nvim" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},

	-- MD file preview
	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	-- { "dhruvasagar/vim-table-mode" }, -- markdown table format
	-- { "vimwiki/vimwiki" },

	-- Git
	{ "lewis6991/gitsigns.nvim" },
	{ "tpope/vim-fugitive" },

	-- DAP
	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui" },
	{ "ravenxrz/DAPInstall.nvim" },
})
