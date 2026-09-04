-- Only the dashboard is enabled. snacks require()s each module
-- lazily, so the rest of the suite is never loaded.
require("snacks").setup({
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
