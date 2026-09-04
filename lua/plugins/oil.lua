-- Oil edits a directory as an ordinary buffer, so y/d/p/x and the plain
-- motions have to keep their vim meaning. Extra keys go behind g, which
-- is why superfile's single-letter bindings do not carry over here.
require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	watch_for_changes = true,

	view_options = { show_hidden = true },

	keymaps = {
		-- Herdr eats <C-h> and niri eats <C-p>, so neither reaches nvim.
		["<C-h>"] = false,
		["<C-p>"] = false,
		["f"] = "actions.preview",

		-- gy/gp move the file itself through the Wayland clipboard, so
		-- oil and a GUI file manager can hand files to each other.
		["gy"] = "actions.copy_to_system_clipboard",
		["gp"] = "actions.paste_from_system_clipboard",
		["gY"] = { "actions.yank_entry", opts = { modify = ":p" } },
	},

	float = {
		max_width = 0.7,
		max_height = 0.8,
	},
})

-- :Oil with no argument opens the directory of the current file.
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { silent = true, desc = "Oil: parent directory" })

vim.keymap.set("n", "<leader>e", function()
	require("oil").toggle_float()
end, { silent = true, desc = "Oil: float" })
