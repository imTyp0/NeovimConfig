local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git", "clone", "--depth", "1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer, close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
		display = {
			open_fn = function()
			return require("packer.util").float({border = "rounded"})
		end,
	},
})

-- Install our plugins here
return packer.startup(function(use)
	--[[ Packer ]]
	use("wbthomason/packer.nvim")

	--[[ Treesitter]]
	use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
	use("hiphish/rainbow-delimiters.nvim")

	--[[ Commenting ]]
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	--[[ Autocomplete - Necessary for LSP ]]
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")

	--[[ Snippets - Necessary for LSP]]
	use({"garymjr/nvim-snippets",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered()
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-g>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.confirm({select = true})
				}),
				sources = cmp.config.sources({
					{name = "nvim_lsp"}
				}),
				{name = "buffer"}
			})
		end,
	})

	--[[ Autopairs ]]
	use("windwp/nvim-autopairs")

	--[[ LSP ]]
	use({
		"williamboman/mason.nvim", -- LSP installer
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig"
	})

	--[[ Others ]]
	use("folke/which-key.nvim") -- Keybinds
	use("norcalli/nvim-colorizer.lua") -- Make CSS color codes colored
	use("stevearc/dressing.nvim") -- Improved UI interfaces

	--[[ Nvim-Tree ]]
	use("akinsho/bufferline.nvim") -- Works with nvim-tree
	use("kyazdani42/nvim-web-devicons") -- Icons for nvim-tree
	use("kyazdani42/nvim-tree.lua") -- Filesystem tree

	--[[ Color scheme ]]
	use "EdenEast/nightfox.nvim"

	--[[ Toggleterm ]]
	use{"akinsho/toggleterm.nvim", tag = "*", config = function()
		require("toggleterm").setup{}
	end}

	-- Automaticall set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
