local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = true,
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function get_opts(desc)
	return { noremap = true, silent = true, desc = desc }
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", get_opts("declaration"))
	keymap(bufnr, "n", "gd", "<cmd>Lspsaga goto_definition<CR>", get_opts("definition"))
	keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", get_opts("hover_doc"))
	keymap(bufnr, "n", "gr", "<cmd>Lspsaga finder ref<CR>", get_opts("find reference"))
	keymap(bufnr, "n", "gI", "<cmd>Lspsaga finder imp<CR>", get_opts("find implemention"))
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", get_opts("diagnostic open float"))
	keymap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_next<cr>", get_opts("diagnostic jump next"))
	keymap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", get_opts("diagnostic jump prev"))
	keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", get_opts("format"))
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", get_opts("lsp info"))
	keymap(bufnr, "n", "<leader>la", "<cmd>Lspsaga code_action<cr>", get_opts("code action"))
	keymap(bufnr, "n", "<leader>lr", "<cmd>Lspsaga rename<cr>", get_opts("rename"))
	keymap(bufnr, "n", "<leader>lo", "<cmd>Lspsaga outline<cr>", get_opts("show outline"))
	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", get_opts("signature_help"))
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)

	-- popup a diagnostic window when cursor hold on error position.(require vim.opt.updatetime)
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
	})
end

return M
