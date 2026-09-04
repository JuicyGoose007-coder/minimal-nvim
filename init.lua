vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("options")
require("ui")

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind

		if name == "nvim-treesitter" and kind ~= "delete" then
			-- On install this fires before the plugin is on rtp.
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			require("nvim-treesitter").update()
		end
	end,
})

local gh = function(x)
	return "https://github.com/" .. x
end

vim.pack.add({
	gh("ellisonleao/gruvbox.nvim"),
	{
		src = gh("nvim-treesitter/nvim-treesitter"),
		version = "main",
	},
	gh("nvim-mini/mini.icons"),
	gh("ibhagwan/fzf-lua"),
	gh("nvim-lua/plenary.nvim"),
	gh("MunifTanjim/nui.nvim"),
	{
		src = gh("nvim-neo-tree/neo-tree.nvim"),
		version = vim.version.range("3.*"),
	},
	gh("lewis6991/gitsigns.nvim"),
	gh("stevearc/conform.nvim"),
	{
		src = gh("Saghen/blink.cmp"),
		version = vim.version.range("1.*"),
	},
	gh("folke/which-key.nvim"),
	gh("folke/lazydev.nvim"),
	gh("folke/snacks.nvim"),
	gh("folke/trouble.nvim"),
})

require("colorscheme")
require("plugins.icons")
require("plugins.treesitter")
require("plugins.fzf")
require("plugins.tree")
require("plugins.gitsigns")
require("plugins.conform")
require("plugins.blink")
require("plugins.whichkey")
require("plugins.lazydev")
require("plugins.trouble")
require("plugins.dashboard")
require("lsp")
require("statusline")
require("autocmds")
require("keymaps")
