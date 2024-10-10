local which_key_config = {
	plugins = {
		marks = true,
		registers = true,
	},

	-- defer = {
	-- 	gc = "Comments",
	-- }
}

--[[ Setup WhichKey ]]
local ok, whichkey = pcall(require, "which-key")
if ok then
	whichkey.setup(which_key_config)
end

local opts = { noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)

local keybinds = {
	-- Clear search highlighting
	{
		mode = "n",
		keymap = "<Esc>",
		action = ":noh<CR>",
		desc = "Clear search highlighting"
	},
	-- NvimTree
	{
		mode = "n",
		keymap = "<Space>t",
		action = "<cmd>NvimTreeToggle<CR>",
		desc = "[t]oggle NvimTree"
	},
	{
		mode = "n",
		keymap = "<Space>T",
		action = "<cmd>NvimTreeFocus<CR>",
		desc = "Focus NvimTree"
	},
	-- Toggleterm
	{
		mode = "n",
		keymap = "<A-i>",
		action = "<cmd>ToggleTerm direction=float<CR>",
		desc = "Open a floating ToggleTerm window"
	},
	{
		mode = "t",
		keymap = "<A-i>",
		action = "<cmd>ToggleTerm direction=float<CR>",
		desc = "Close a floating ToggleTerm window"
	}
}

--[[ Set the keymaps ]]
for _, km in ipairs(keybinds) do
	keymap(km.mode, km.keymap, km.action, {noremap = true, silent = true, desc = km.desc})
end
