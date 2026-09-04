vim.lsp.enable({
	"lua_ls",
	"bashls",
	"pyright",
	"ruff",
	"ts_ls",
})

vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "E",
			[vim.diagnostic.severity.WARN] = "W",
			[vim.diagnostic.severity.INFO] = "I",
			[vim.diagnostic.severity.HINT] = "H",
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
			buffer = event.buf,
			desc = "Go to definition",
		})
	end,
})
