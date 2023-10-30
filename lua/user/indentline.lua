local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
  return
end

local highlight = {
  "RainbowBlue"
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61afef" })
end)

indent_blankline.setup {
  scope = { highlight = highlight }
}
