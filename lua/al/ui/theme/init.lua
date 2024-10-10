-- hide tildes at end of buffers
vim.cmd([[ set fillchars=eob:\ ]])

-- set colorscheme here
local colorscheme = "nordfox"

-- set the color scheme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
