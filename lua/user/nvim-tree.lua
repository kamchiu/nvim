local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
	return
end

-- local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
-- print(status_ok)
-- if not config_status_ok then
-- 	return
-- end

-- local tree_cb = nvim_tree_config.nvim_tree_callback

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	local function edit_or_open()
		local node = api.tree.get_node_under_cursor()

		if node.nodes ~= nil then
			-- expand or collapse folder
			api.node.open.edit()
		else
			-- open file
			api.node.open.edit()
			-- Close the tree if file was opened
			api.tree.close()
		end
	end

	-- open as vsplit on current node
	local function vsplit_preview()
		local node = api.tree.get_node_under_cursor()

		if node.nodes ~= nil then
			-- expand or collapse folder
			api.node.open.edit()
		else
			-- open file as vsplit
			api.node.open.vertical()
		end

		-- Finally refocus on tree if it was lost
		api.tree.focus()
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
	vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
	vim.keymap.set("n", "h", api.tree.close, opts("Close"))
	vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

nvim_tree.setup({
	hijack_cursor = true,
	sync_root_with_cwd = true,
	view = {
		adaptive_size = false,
	},
	on_attach = my_on_attach,
	renderer = {
		full_name = true,
		group_empty = true,
		special_files = {},
		symlink_destination = false,
		indent_markers = {
			enable = true,
		},
		icons = {
			git_placement = "signcolumn",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
			},
		},
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = { "help" },
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	filters = {
		custom = {
			"^.git$",
		},
	},
	actions = {
		change_dir = {
			enable = false,
			restrict_above_cwd = true,
		},
		open_file = {
			resize_window = true,
			window_picker = {
				chars = "aoeui",
			},
		},
		remove_file = {
			close_window = false,
		},
	},
	log = {
		enable = false,
		truncate = true,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			diagnostics = false,
			git = false,
			profile = false,
			watcher = false,
		},
	},
})

-- nvim_tree.setup({
--
-- 	actions = {
-- 		open_file = { quit_on_open = true },
-- 	},
-- 	update_focused_file = {
-- 		enable = true,
-- 		update_cwd = true,
-- 	},
-- 	renderer = {
-- 		root_folder_modifier = ":t",
-- 		icons = {
-- 			glyphs = {
-- 				default = "",
-- 				symlink = "",
-- 				folder = {
-- 					arrow_open = "",
-- 					arrow_closed = "",
-- 					default = "",
-- 					open = "",
-- 					empty = "",
-- 					empty_open = "",
-- 					symlink = "",
-- 					symlink_open = "",
-- 				},
-- 				git = {
-- 					unstaged = "",
-- 					staged = "S",
-- 					unmerged = "",
-- 					renamed = "➜",
-- 					untracked = "U",
-- 					deleted = "",
-- 					ignored = "◌",
-- 				},
-- 			},
-- 		},
-- 	},
-- 	diagnostics = {
-- 		enable = true,
-- 		show_on_dirs = true,
-- 		icons = {
-- 			hint = "",
-- 			info = "",
-- 			warning = "",
-- 			error = "",
-- 		},
-- 	},
-- 	view = {
-- 		centralize_selection = true,
-- 		mappings = {
-- 			list = {
-- 				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
-- 				{ key = "h", cb = tree_cb("close_node") },
-- 				{ key = "v", cb = tree_cb("vsplit") },
-- 			},
-- 		},
-- 	},
-- })

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
