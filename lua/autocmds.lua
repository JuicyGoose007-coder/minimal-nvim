-- Highlight the affected region on yank and on put
vim.api.nvim_create_autocmd({ "TextYankPost", "TextPutPost" }, {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight region on yank and put",
	callback = function()
		vim.hl.hl_op({ timeout = 200 })
	end,
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		-- Commit buffers are new each time; the mark is stale.
		local ft = vim.bo[args.buf].filetype
		if ft == "gitcommit" or ft == "gitrebase" then
			return
		end

		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- zoxide only learns directories you cd into in a shell, so a project you
-- only ever open in nvim never reaches <leader>sp. Report them here too.
if vim.fn.executable("zoxide") == 1 then
	local recorded = {}
	local home = vim.uv.os_homedir()
	local plugins = vim.fn.stdpath("data")

	vim.api.nvim_create_autocmd("BufWinEnter", {
		group = vim.api.nvim_create_augroup("zoxide_add", { clear = true }),
		desc = "record the project root in zoxide",
		callback = function(args)
			-- Terminals, quickfix and help windows have no project.
			if vim.bo[args.buf].buftype ~= "" then
				return
			end

			-- A no-name buffer falls back to cwd inside root(), which
			-- would record wherever nvim was launched. Oil buffers are
			-- named oil:///... so they still pass.
			if vim.api.nvim_buf_get_name(args.buf) == "" then
				return
			end

			local dir = require("project").root(args.buf)

			-- Your own directories only, and never plugin source that a
			-- gd jump happened to land in.
			if not vim.startswith(dir, home) or vim.startswith(dir, plugins) then
				return
			end

			-- Once per directory per session: zoxide scores sessions,
			-- not keystrokes.
			if recorded[dir] then
				return
			end
			recorded[dir] = true

			vim.system({ "zoxide", "add", dir })
		end,
	})
end
