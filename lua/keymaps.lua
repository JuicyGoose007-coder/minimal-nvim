-- Write and quit
vim.keymap.set("n", "<leader>w", ":w<cr>", { silent = true, desc = "Write" })
vim.keymap.set("n", "<leader>q", ":q<cr>", { silent = true, desc = "Quit" })

-- Redo
vim.keymap.set("n", "U", "<c-r>", { silent = true, desc = "Redo" })

-- Restart
vim.keymap.set("n", "<leader>R", ":restart<cr>", { silent = true, desc = "Restart" })

-- Pack update
vim.keymap.set("n", "<leader>u", "<cmd>packupdate<cr>", { silent = true, desc = "Update Packages" })

-- vim.ui.open returns (cmd, err): the handler is only known to have
-- worked once it exits 0, so wait on it like Nvim's own gx does.
local function open_uri(uri)
	local cmd, err = vim.ui.open(uri)
	local rv = cmd and cmd:wait(1000) or nil
	if cmd and rv and rv.code ~= 0 then
		err = ("vim.ui.open: command %s (%d): %s"):format(
			rv.code == 124 and "timeout" or "failed",
			rv.code,
			vim.inspect(cmd.cmd)
		)
	end
	return err
end

-- Nvim's gx falls back to the filename under the cursor and hands it to
-- xdg-open, which has no handler here and forks a headless nvim that
-- never exits. Local paths open in this editor instead.
vim.keymap.set("n", "gx", function()
	for _, target in ipairs(require("vim.ui")._get_urls()) do
		if target:match("^%a[%w+.-]*:") then
			local err = open_uri(target)
			if err then
				vim.notify(err, vim.log.levels.ERROR)
			end
		elseif target ~= "" then
			local path = vim.fn.fnamemodify(target, ":p")
			if vim.uv.fs_stat(path) then
				vim.cmd.edit(vim.fn.fnameescape(path))
			else
				vim.notify("No such file: " .. target, vim.log.levels.WARN)
			end
		end
	end
end, { silent = true, desc = "Open URL, or file under cursor" })

-- Window moves are <C-w>h/j/k/l. Do NOT map <C-h/j/k/l>:
-- Herdr binds those as direct chords for pane focus and
-- they never reach nvim. Same for <C-b>, its prefix.
