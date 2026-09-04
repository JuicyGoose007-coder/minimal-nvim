local fzf = require("fzf-lua")

fzf.setup({})

local map = function(lhs, fn, desc)
	vim.keymap.set("n", lhs, fn, { silent = true, desc = desc })
end

map("<leader>f", fzf.files, "Find files")
map("<leader>g", fzf.live_grep, "Live grep")
map("<leader>sb", fzf.buffers, "Buffers")
map("<leader>sh", fzf.helptags, "Help tags")
map("<leader>sd", fzf.diagnostics_document, "Diagnostics")
map("<leader>ss", fzf.lsp_document_symbols, "Symbols")
map("<leader>sk", fzf.keymaps, "Keymaps")
map("<leader>sr", fzf.oldfiles, "Recent files")
map("<leader>sp", fzf.zoxide, "Jump to project")
map("<leader>sl", fzf.lines, "Lines in open buffers")
map("<leader>/", fzf.blines, "Search Current File")
