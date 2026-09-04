local pms = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
local dir = vim.api.nvim_get_hl(0, { name = "Directory", link = false })
local vis = vim.api.nvim_get_hl(0, { name = "Visual", link = false })
vim.api.nvim_set_hl(0, "StlMode", { fg = pms.fg, bg = vis.bg })
vim.api.nvim_set_hl(0, "StlGit", { fg = dir.fg, bg = pms.bg })

local modes = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	V = "V-LINE",
	["\22"] = "V-BLOCK",
	c = "COMMAND",
	t = "TERMINAL",
	R = "REPLACE",
	s = "SELECT",
	S = "S-LINE",
	["\19"] = "S-BLOCK",
}

local labels = { " ", " ", " ", " " }
local hls = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }

function _G._statusline()
	local mode = modes[vim.fn.mode()] or vim.fn.mode():upper()

	-- gitsigns maintains this; the old config shelled out to `git` twice
	-- on every BufEnter to get the same string.
	local head = vim.b.gitsigns_head
	local branch = head and ("%#StlGit# " .. head .. " %*") or ""

	-- cwd-relative, no subprocess.
	local path = vim.fn.expand("%:.")
	if path == "" then
		path = "[No Name]"
	end

	local diag = ""
	local counts = vim.diagnostic.count(0) or {}
	for i = 1, 4 do
		if counts[i] and counts[i] > 0 then
			diag = diag .. "%#" .. hls[i] .. "#" .. labels[i] .. counts[i] .. "%* "
		end
	end

	return "%#StlMode# " .. mode .. " %*" .. branch .. " " .. path .. "%=" .. diag .. vim.bo.filetype .. " %l:%c"
end

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		vim.cmd("redrawstatus!")
	end,
})

vim.o.statusline = "%!v:lua._statusline()"
