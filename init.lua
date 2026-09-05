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
	gh("nvim-mini/mini.pairs"),
	gh("ibhagwan/fzf-lua"),
	gh("stevearc/oil.nvim"),
	gh("jiaoshijie/undotree"),
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
	-- Default mappings are <C-h/j/k/l>, which is what ~/.config/tmux/tmux.conf
	-- hands over when the pane's foreground command is nvim.
	gh("christoomey/vim-tmux-navigator"),
})

require("colorscheme")
require("plugins.icons")
require("plugins.pairs")
require("plugins.treesitter")
require("plugins.fzf")
require("plugins.oil")
require("plugins.undotree")
require("plugins.gitsigns")
require("plugins.conform")
require("plugins.blink")
require("plugins.whichkey")
require("plugins.lazydev")
require("plugins.trouble")
require("plugins.snacks")
require("lsp")
require("statusline")
require("autocmds")
require("keymaps")
