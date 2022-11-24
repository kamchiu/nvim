vim.g.vimwiki_list = {{ path = "~/vimwiki", syntax = 'markdown', ext = '*.md' }}

-- Markdown autocmd
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,1 #<Space><Enter><++><Esc>kA]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,2 ##<Space><Enter><++><Esc>kA]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,3 ###<Space><Enter><++><Esc>kA]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,4 ####<Space><Enter><++><Esc>kA]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,n ---<Enter><Enter>]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,b **** <++><Esc>F*hi]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,s ~~~~ <++><Esc>F~hi]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,i ** <++><Esc>F*i]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,d `` <++><Esc>F`i]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,h ====<Space><++><Esc>F=hi]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,p ![](<++>) <++><Esc>F[a]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[inoremap ,a [](<++>) <++><Esc>F[a]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	command = [[,l --------<Enter>]],
})
