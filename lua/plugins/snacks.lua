-- snacks require()s each module lazily, so anything left out here
-- is never loaded at all.
require("snacks").setup({
	bigfile = { enabled = true },
	notifier = { enabled = true },
	words = { enabled = true },

	-- Draws images in the terminal over kitty's graphics protocol, so oil's
	-- preview (f) shows the picture instead of the bytes. Nvim 0.13 has its
	-- own vim.ui.img, but it is PNG-only and nothing calls it from oil.
	-- Non-PNG formats go through `magick`.
	image = { enabled = true },

	indent = {
		enabled = true,
		-- Scope guides animate by default, redrawing on every cursor
		-- move. Flip this to true to try it.
		animate = { enabled = false },
	},

	dashboard = {
		enabled = true,
		-- Default sections include "startup", which hard-requires
		-- lazy.stats and throws under vim.pack, killing the render.
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
		},
		preset = {
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{ icon = " ", key = "p", desc = "Jump to Project", action = ":lua Snacks.dashboard.pick('zoxide')" },
				{
					icon = " ",
					key = "c",
					desc = "Config",
					action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
				},
				{ icon = " ", key = "u", desc = "Update Packages", action = ":packupdate" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
	},
})

vim.keymap.set("n", "<leader>n", function()
	Snacks.notifier.show_history()
end, { silent = true, desc = "Notification history" })

vim.keymap.set("n", "<leader>N", function()
	Snacks.notifier.hide()
end, { silent = true, desc = "Dismiss notifications" })
