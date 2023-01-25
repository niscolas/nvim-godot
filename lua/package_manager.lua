local plugins_install_path = vim.fn.stdpath("data")
    .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false

-- `packer` is our package manager and it needs to be downloaded externally
-- before loading any plugin
local bootstrap_packer = function()
    if vim.fn.empty(vim.fn.glob(plugins_install_path)) > 0 then
        is_bootstrap = true
        vim.fn.system {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            plugins_install_path,
        }
        vim.cmd([[packadd packer.nvim]])
    end
end

bootstrap_packer()

-- for each package listed here, you can search on github for their
-- name to know more
require("packer").startup(function(use)
    -- package manger
    use { "wbthomason/packer.nvim" }

    -- lsp: language server protocol
    use { "folke/neodev.nvim" }
    use { "neovim/nvim-lspconfig" }
    use { "williamboman/mason-lspconfig.nvim" }
    use { "williamboman/mason.nvim" }
    use { "jose-elias-alvarez/null-ls.nvim" }

    -- dap: debug adapter protocol (debugger)
    use { "mfussenegger/nvim-dap" }

    -- nvim-cmp: autocompletion
    use { "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "L3MON4D3/LuaSnip" }
    use { "saadparwaiz1/cmp_luasnip" }

    -- treesitter: code highlighting
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            pcall(require("nvim-treesitter.install").update {
                with_sync = true,
            })
        end,
    }
    use { -- Additional text objects via treesitter
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    }

    -- git
    use { "lewis6991/gitsigns.nvim" }
    use { "tpope/vim-fugitive" }
    use { "tpope/vim-rhubarb" }

    -- ui
    use { "lukas-reineke/indent-blankline.nvim" } -- add indentation guides even on blank lines
    use { "numToStr/Comment.nvim" } -- "gc" to comment visual regions/lines
    use { "nvim-lualine/lualine.nvim" }
    use { "sainnhe/everforest" }
    use { "tpope/vim-sleuth" } -- detect tabstop and shiftwidth automatically

    -- telescope
    use { "nvim-telescope/telescope.nvim" }
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        cond = vim.fn.executable("make") == 1,
    }

    -- misc
    use { "nvim-lua/plenary.nvim" }
    use { "folke/which-key.nvim" }

    if is_bootstrap then
        require("packer").sync()
    end
end)

-- when we are bootstrapping a configuration, it doesn"t
-- make sense to execute the rest of the init.lua.
-- you"ll need to restart nvim, and then it will work.
if is_bootstrap then
    print("==================================")
    print("    plugins are being installed")
    print("    wait until packer completes,")
    print("       then restart nvim")
    print("==================================")
end

return is_bootstrap
