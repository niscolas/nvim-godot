-- [[ Configure Lualine ]]
-- See `:help lualine`
require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "everforest",
        component_separators = "|",
        section_separators = "",
    },
}

-- [[ Configure Comment.nvim ]]
-- See `:help comment-nvim`
require("Comment").setup()

-- [[ Configure indent-blankline.nvim ]]
-- See `:help indent_blankline`
require("indent_blankline").setup {
    char = "┊",
    show_trailing_blankline_indent = false,
}

-- [[ Configure Gitsigns ]]
-- See `:help gitsigns`
require("gitsigns").setup {
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set(
    "n",
    "<leader>?",
    require("telescope.builtin").oldfiles,
    { desc = "[?] Find recently opened files" }
)
vim.keymap.set(
    "n",
    "<leader><space>",
    require("telescope.builtin").buffers,
    { desc = "[ ] Find existing buffers" }
)
vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown {
            winblend = 10,
            previewer = false,
        }
    )
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set(
    "n",
    "<leader>sf",
    require("telescope.builtin").find_files,
    { desc = "[S]earch [F]iles" }
)
vim.keymap.set(
    "n",
    "<leader>sh",
    require("telescope.builtin").help_tags,
    { desc = "[S]earch [H]elp" }
)
vim.keymap.set(
    "n",
    "<leader>sw",
    require("telescope.builtin").grep_string,
    { desc = "[S]earch current [W]ord" }
)
vim.keymap.set(
    "n",
    "<leader>sg",
    require("telescope.builtin").live_grep,
    { desc = "[S]earch by [G]rep" }
)
vim.keymap.set(
    "n",
    "<leader>sd",
    require("telescope.builtin").diagnostics,
    { desc = "[S]earch [D]iagnostics" }
)

-- [[ Configure Treesitter ]]
-- See `:help which-key.nvim`
require("which-key").setup()

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup {
    -- Add languages to be installed here that you want installed for treesitter
    -- Uncomment other languagues if needed
    ensure_installed = {
        -- "c",
        -- "cpp",
        -- "go",
        -- "python",
        -- "rust",
        -- "typescript",

        "c_sharp",
        "gdscript",
        "lua",
        "help",
        "vim",
    },

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
}

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don"t have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap(
        "gr",
        require("telescope.builtin").lsp_references,
        "[G]oto [R]eferences"
    )
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap(
        "<leader>ds",
        require("telescope.builtin").lsp_document_symbols,
        "[D]ocument [S]ymbols"
    )
    nmap(
        "<leader>ws",
        require("telescope.builtin").lsp_dynamic_workspace_symbols,
        "[W]orkspace [S]ymbols"
    )

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap(
        "<leader>wa",
        vim.lsp.buf.add_workspace_folder,
        "[W]orkspace [A]dd Folder"
    )
    nmap(
        "<leader>wr",
        vim.lsp.buf.remove_workspace_folder,
        "[W]orkspace [R]emove Folder"
    )
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")
end

-- Enable the following language servers
--  feel free to add/remove any lsps that you want here. they will automatically be installed.
--  add any additional override configuration in the following tables. they will be passed to
--  the `settings` field of the server config. you must look up that documentation yourself.
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},

    gdscript = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

local ensure_installed_servers = { "lua_ls" }

-- [[ Configure null-ls ]]
local null_ls = require("null-ls")

local lsp_format = function(bufnr)
    vim.lsp.buf.format {
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    }
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls_on_attach = function(client, bufnr)
    if not client.supports_method("textDocument/formatting") then
        return
    end

    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
            lsp_format(bufnr)
        end,
    })
end

null_ls.setup {
    on_attach = null_ls_on_attach,
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.gdformat,
    },
}

-- [[ Configure Neodev ]]
require("neodev").setup()

-- [[ Configure Cmp (1) ]]
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- [[ Configure Mason / Mason-LSPconfig ]]
-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup {
    ensure_installed = ensure_installed_servers,
}

for server, opts in pairs(servers) do
    require("lspconfig")[server].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = opts,
    }
end

-- [[ Configure Cmp (2), Luasnip ]]
-- See `:help nvim-cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
}

local setup_godot_dap = function()
    local dap = require("dap")

    dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
    }

    dap.configurations.gdscript = {
        {
            launch_game_instance = false,
            launch_scene = false,
            name = "Launch scene",
            project = "${workspaceFolder}",
            request = "launch",
            type = "godot",
        },
    }
end

setup_godot_dap()
