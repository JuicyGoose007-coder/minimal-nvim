-- Keys inside the tree mirror ~/.config/superfile/hotkeys.toml so both
-- file managers share one set of habits. Anything superfile has no
-- concept of keeps its stock neo-tree binding.
require("neo-tree").setup({
	-- Only the filesystem tree. The buffers and git_status sources
	-- stay unloaded, which is most of neo-tree's startup cost.
	sources = { "filesystem" },

	-- copy_to_clipboard is a file operation, not a yank, so the two
	-- path grabs need commands of their own.
	commands = {
		copy_absolute_path = function(state)
			local node = state.tree:get_node()
			if not node then
				return
			end
			vim.fn.setreg("+", node.path)
			vim.notify(node.path)
		end,

		copy_working_directory = function(state)
			local path = state.path or vim.fn.getcwd()
			vim.fn.setreg("+", path)
			vim.notify(path)
		end,
	},

	window = {
		width = 32,
		mappings = {
			-- Leader is <space>, and stock neo-tree binds it to
			-- toggle_node: it would eat every leader sequence here.
			["<space>"] = "none",

			-- Navigation. confirm = enter/l, parent_directory = -/h.
			["l"] = "open",
			["h"] = "close_node",

			-- Editor actions.
			["e"] = "open",
			["E"] = "set_root",

			-- File operations. Stock d deletes permanently; superfile
			-- trashes on d, and neo-tree trashes via `gio trash`.
			["y"] = "copy_to_clipboard",
			["Y"] = "copy_absolute_path",
			["d"] = "trash",
			["D"] = "delete",

			-- Panels and views.
			["f"] = "toggle_preview",
			["/"] = "fuzzy_finder",
			["."] = "toggle_hidden",
			["v"] = "select",
			["?"] = "show_help",
			["c"] = "copy_working_directory",
		},
	},

	filesystem = {
		hijack_netrw_behavior = "disabled",
		group_empty_dirs = true,
		filtered_items = { hide_dotfiles = false },

		-- Reveal and highlight the current buffer, uncollapsing folders
		-- as needed. The root is left where it is, so opening a file
		-- outside cwd does not move it.
		follow_current_file = { enabled = true },
	},
})

local function is_tree(buf)
	return vim.bo[buf].filetype == "neo-tree"
end

-- Jump to the tree, positioned on the current file, or back
-- to the window you came from. ctrl+hjkl belongs to Herdr,
-- so this is the only key that crosses the border.
local function tree_focus_toggle()
	if is_tree(0) then
		vim.cmd.wincmd("p")
	else
		require("neo-tree.command").execute({ action = "focus", reveal = true })
	end
end

vim.keymap.set("n", "<leader>e", tree_focus_toggle, {
	silent = true,
	desc = "Tree: jump to file / back",
})

vim.keymap.set("n", "<leader>E", "<cmd>Neotree toggle<cr>", {
	silent = true,
	desc = "Tree: open / close",
})

-- Closing the last file should exit nvim, not leave a lone
-- tree sitting there. QuitPre runs before the window goes,
-- so the window being quit is still in the list: one other
-- window left means it is the last one.
vim.api.nvim_create_autocmd("QuitPre", {
	desc = "Tree: close it when the last file quits",
	callback = function()
		-- Quitting from inside the tree just closes the tree.
		if is_tree(0) then
			return
		end

		local trees, others = {}, 0
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			-- Floats (which-key, fzf, blink) are not windows
			-- you can be left alone with.
			if vim.api.nvim_win_get_config(win).relative == "" then
				if is_tree(vim.api.nvim_win_get_buf(win)) then
					table.insert(trees, win)
				else
					others = others + 1
				end
			end
		end

		if others == 1 then
			for _, win in ipairs(trees) do
				vim.api.nvim_win_close(win, true)
			end
		end
	end,
})
