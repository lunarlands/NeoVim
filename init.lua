--  _   _ _____ _____     _____ __  __ 
-- | \ | | ____/ _ \ \   / /_ _|  \/  |
-- |  \| |  _|| | | \ \ / / | || |\/| |
-- | |\  | |__| |_| |\ V /  | || |  | |
-- |_| \_|_____\___/  \_/  |___|_|  |_|
--
-- TZGML & Republic Of Lunar's NEOVIM
-- Version 250512
--
--   -------------CONTRIBUTORS------------
--   | TZGML             | Author        |
--   | Republic Of Lunar | Modifier      |
--   -------------------------------------
--
-- Tips: Colorscheme ":160"
--
--------------------------------------------------------------------
-- Model 1 - Basic Configs                                         |
--------------------------------------------------------------------
vim.o.incsearch = true
vim.o.undofile = true
vim.g.indentLine_fileTypeExclude = {"dashboard"}
vim.opt.clipboard = "unnamedplus"
vim.wo.colorcolumn = "146"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.number = true
vim.o.scrolloff = 15
vim.wo.cursorline = true
vim.wo.signcolumn = "yes"
vim.o.t_Co = "256"
vim.o.hlsearch = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.g.navic_silence = true
if vim.g.neovide then
    vim.o.guifont = "VictorMono Nerd Font:h11"
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_cursor_vfx_mode = "ripple"
    vim.neovide_confirm_quit = true
end

-----------------------------------------------------------------
-- Model 2 - Package Manager                                    |
-----------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({{"RRethy/vim-illuminate"}, {
    "L3MON4D3/LuaSnip",
    build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
    dependencies = {"rafamadriz/friendly-snippets", "benfowler/telescope-luasnip.nvim"},
    config = function(_, opts)
        if opts then
            require("luasnip").config.setup(opts)
        end
        vim.tbl_map(function(type)
            require("luasnip.loaders.from_" .. type).lazy_load()
        end, {"vscode", "snipmate", "lua"})
        -- friendly-snippets - enable standardized comments snippets
        require("luasnip").filetype_extend("typescript", {"tsdoc"})
        require("luasnip").filetype_extend("javascript", {"jsdoc"})
        require("luasnip").filetype_extend("lua", {"luadoc"})
        require("luasnip").filetype_extend("python", {"pydoc", "django", "flask"})
        require("luasnip").filetype_extend("rust", {"rustdoc"})
        require("luasnip").filetype_extend("cs", {"csharpdoc"})
        -- require("luasnip").filetype_extend("java", { "javadoc" })
        require("luasnip").filetype_extend("c", {"cdoc"})
        require("luasnip").filetype_extend("cpp", {"cppdoc"})
        require("luasnip").filetype_extend("php", {"phpdoc"})
        require("luasnip").filetype_extend("kotlin", {"kdoc"})
        require("luasnip").filetype_extend("ruby", {"rdoc"})
        require("luasnip").filetype_extend("sh", {"shelldoc"})
    end
}, {
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async"
}, {
    "VidocqH/lsp-lens.nvim",
    config = function()
        require("lsp-lens").setup({
            enable = true,
            LspLens = {
                link = "Comment"
            },
            include_declaration = false, -- Reference include declaration
            ignore_filetype = {"prisma"},
            sections = {
                definition = function(count)
                    return "函数: " .. count
                end,
                references = function(count)
                    return "传参: " .. count -- References
                end,
                implements = function(count)
                    return "实施: " .. count -- Implements
                end,
                git_authors = function(latest_author, count)
                    return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
                end
            }
        })
    end
}, {
    "nvimdev/lspsaga.nvim",
    config = function()
        require("lspsaga").setup({})
    end,
    dependencies = {"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"}
}, {
    "folke/trouble.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"}
}, {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {"SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons"}
}, {"xiyaowong/transparent.nvim"}, {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({})
    end
}, {
    "nvim-lualine/lualine.nvim",
    requires = {
        "nvim-tree/nvim-web-devicons",
        opt = true,
    },
    dependencies = {"arkav/lualine-lsp-progress"},
    config = function()
        require('lualine').setup {
        }
    end
}, {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("nvim-tree").setup({
            view = {
                width = 30
            },
            renderer = {
                group_empty = true
            }
        })
    end
}, {
    "ethanholz/nvim-lastplace",
    config = true
}, {"ellisonleao/gruvbox.nvim"}, {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme("tokyonight-night")
    end
}, {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        integrations = {
            telescope = true,
            harpoon = true,
            mason = true,
            neotest = true
        }
    },
    config = function(_, opts)
        -- require("catppuccin").setup(opts)
        -- vim.cmd.colorscheme 'catppuccin-mocha'
    end
}, {
    "rose-pine/neovim",
    name = "rose-pine"
}, {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = {},
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil
            }
        })
    end
}, {
    "folke/lsp-colors.nvim",
    config = function()
        require("lsp-colors").setup({
            Error = "#f38ba8",
            Warning = "#fab387",
            Information = "#74c7ec",
            Hint = "#a6e3a1"
        })
    end
}, {"mhartington/formatter.nvim"}, {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup({
            padding = true,
            sticky = true,
            ignore = nil,
            toggler = {
                line = "zz",
                block = "lz"
            },
            opleader = {
                line = "gc",
                block = "gb"
            },
            extra = {
                above = "gcO",
                below = "gco",
                eol = "gcA"
            },
            mappings = {
                basic = true,
                extra = true
            },
            pre_hook = nil,
            post_hook = nil
        })
    end
}, {
    "williamboman/mason.nvim",
    dependencies = {"neovim/nvim-lspconfig"},
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })
    end
}, {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {{"neovim/nvim-lspconfig"}, -- Required
    { -- Optional
        "williamboman/mason.nvim",
        build = function()
            pcall(vim.cmd, "MasonUpdate")
        end
    }, {"williamboman/mason-lspconfig.nvim"}, -- Optional
    {"hrsh7th/nvim-cmp"}, -- Required
    {"hrsh7th/cmp-nvim-lsp"}, -- Required
    {"onsails/lspkind-nvim"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-cmdline"}, {"hrsh7th/cmp-path"},
                    {"rafamadriz/friendly-snippets"}}
}, {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
        local highlight = {"RainbowRed", "RainbowOrange", "RainbowYellow", "RainbowGreen", "RainbowCyan", "RainbowBlue",
                           "RainbowViolet"}
        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", {
                fg = "#f38ba8"
            })
            vim.api.nvim_set_hl(0, "RainbowYellow", {
                fg = "#e5c890"
            })
            vim.api.nvim_set_hl(0, "RainbowBlue", {
                fg = "#89b4fa"
            })
            vim.api.nvim_set_hl(0, "RainbowOrange", {
                fg = "#fab387"
            })
            vim.api.nvim_set_hl(0, "RainbowGreen", {
                fg = "#a6e3a1"
            })
            vim.api.nvim_set_hl(0, "RainbowViolet", {
                fg = "#b4befe"
            })
            vim.api.nvim_set_hl(0, "RainbowCyan", {
                fg = "#89dceb"
            })
        end)

        require("ibl").setup({
            indent = {
                highlight = highlight
            }
        })
    end
}, {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true
}, {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
        require("everforest").setup({
        -- Your config here
        })
    end,
}, {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {{"tpope/vim-dadbod"}}
}, {"kristijanhusak/vim-dadbod-completion"}, {
    "rcarriga/nvim-notify",
    config = function(_, opts)
        vim.notify = require("notify")
        require("notify").setup(vim.tbl_extend("keep", {
            background_colour = "#000000"
        }, opts))
    end
}, {
    "nvimdev/dashboard-nvim",
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            -- config
        }
    end,
    dependencies = {{"nvim-tree/nvim-web-devicons"}}
}, {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup()
    end
}, {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"},
    config = function()
        require("noice").setup({
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true
                }
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false
            }
        })
    end
}, {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = {"nvim-lua/plenary.nvim"}
}, {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}
}, {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.config
    opts = {},
    keys = {{
        "s",
        mode = {"n", "x", "o"},
        function()
            require("flash").jump()
        end,
        desc = "Flash"
    }, {
        "S",
        mode = {"n", "o", "x"},
        function()
            require("flash").treesitter()
        end,
        desc = "Flash Treesitter"
    }, {
        "r",
        mode = "o",
        function()
            require("flash").remote()
        end,
        desc = "Remote Flash"
    }, {
        "R",
        mode = {"o", "x"},
        function()
            require("flash").treesitter_search()
        end,
        desc = "Treesitter Search"
    }, {
        "<c-s>",
        mode = {"c"},
        function()
            require("flash").toggle()
        end,
        desc = "Toggle Flash Search"
    }}
}, {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()
    end
}, {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {"tpope/vim-dadbod"}
}, {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}, {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    config = function()
        require("nvim-navic").setup()
        on_attach = on_attach
    end
}, {
    "SmiteshP/nvim-navbuddy",
    requires = {"neovim/nvim-lspconfig", "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim", "numToStr/Comment.nvim", -- Optional
                "nvim-telescope/telescope.nvim" -- Optional
    }
}, {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
        local rainbow_delimiters = require("rainbow-delimiters")

        vim.g.rainbow_delimiters = {
            strategy = {
                [""] = rainbow_delimiters.strategy["global"],
                vim = rainbow_delimiters.strategy["local"]
            },
            query = {
                [""] = "rainbow-delimiters",
                lua = "rainbow-blocks"
            },
            highlight = {"RainbowDelimiterRed", "RainbowDelimiterOrange", "RainbowDelimiterYellow",
                         "RainbowDelimiterGreen", "RainbowDelimiterCyan", "RainbowDelimiterBlue",
                         "RainbowDelimiterViolet"}
        }
    end
}, {
    "kosayoda/nvim-lightbulb",
    config = function()
        require("nvim-lightbulb").setup({
            autocmd = {
                enabled = true
            }
        })
    end
}, {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
}, {
    "simrat39/symbols-outline.nvim",
    config = function()
        require("symbols-outline").setup()
    end
}, {"saadparwaiz1/cmp_luasnip"
}, 
})




------------------------------------------------------------------------------
-- Model 3 - Configs                                                         |
------------------------------------------------------------------------------
vim.api.nvim_set_keymap("i", "jk", "<esc>", {
    silent = true,
    noremap = true
})
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w-h>", {
    silent = true,
    noremap = true
})

vim.api.nvim_set_keymap("n", "<c-p>", "<cmd>!python %<CR>", {
    silent = true,
    noremap = true
})

-- lspsaga
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua require('lspsaga.rename').rename()<CR>", {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap("n", "bc", "<cmd>Lspsaga code_action<CR>", {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap("n", "dj", "<cmd>Lspsaga hover_doc<CR>", {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap("n", "sl", "<cmd>Lspsaga show_line_diagnostics<CR>", {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap("n", "lf", "<cmd>Lspsaga lsp_finder<CR>", {
    noremap = true,
    silent = true
})

vim.api.nvim_set_keymap("n", "<C-y>", "<cmd>lua vim.lsp.buf.declaration()<CR>", {
    silent = true,
    noremap = true
})
-- 打开大纲
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>SymbolsOutline<CR>", {
    silent = true,
    noremap = true
})
-- vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>TagbarToggle<CR>", { noremap = true, silent = true })
-- 打开文件树
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", {
    noremap = true,
    silent = true
})
-- 顶部文件左右移动 --
vim.api.nvim_set_keymap("n", "<leader>bp", ":BufferLineCyclePrev<CR>", {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap("n", "<leader>bn", ":BufferLineCycleNext<CR>", {
    noremap = true,
    silent = true
})
-- 打开一个浮动终端 --
-- vim.api.nvim_set_keymap("n", "<C-t>", ":FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>ToggleTerm<CR>", {
    noremap = true,
    silent = true
})
-- 文件查找 --
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", {
    noremap = true,
    silent = true
})
-- nvim 格式化代码
vim.keymap.set("n", "fr", "<cmd>Format<CR>")
vim.keymap.set("n", "fw", "<cmd>FormatWrite<CR>")

vim.keymap.set("n", "<C-o>", "<cmd>TransparentToggle<CR>")
---配置区----------------------------------------------------------------------------------------------------------------------------------------
require("mason-lspconfig").setup({
    ensure_installed = { -- "lua_ls",
    "bashls", "pyright", "vimls", "jdtls"}
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
local lspkind = require("lspkind")
local lsp = require("lsp-zero").preset({})
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({
        buffer = bufnr
    })
end)
lsp.setup()
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
cmp.setup({
    mapping = {
        -- 补全的一些设置，具体不清楚
        ["<CR>"] = cmp.mapping.confirm({
            select = true
        }),
        ["<C-l>"] = cmp.mapping.complete(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item()
    },
    -- 让nvim根据name里面的参数进行补全
    sources = cmp.config.sources({{
        name = "nvim_lsp"
    }, {
        name = "luasnip"
    }, {
        name = "buffer"
    }, {
        name = "path"
    }}),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    formatting = {
        fields = {"kind", "abbr", "menu"},
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                ultisnips = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]"
            })[entry.source.name]
            return vim_item
        end
    }
})
local cmp = require("cmp")
cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({{
        name = "buffer"
    }})
})
-- nvim命令行补全
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{
        name = "path"
    }}, {{
        name = "cmdline"
    }})
})

-- 文件内容搜索补全

cmp.setup.cmdline({"/"}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{
        name = "buffer"
    }}
})

local lspkind = require("lspkind")
cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol", -- show only symbol annotations
            maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            before = function(entry, vim_item)
                return vim_item
            end
        })
    }
})

local dap = require("dap")
dap.adapters.python = {
    type = "executable",
    command = "python",
    args = {"-m", "debugpy.adapter"}
}
dap.configurations.python = {{
    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch",
    name = "Launch file",
    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
        else
            return "/usr/bin/python"
        end
    end
}, {
    type = "python",
    request = "attach",
    name = "Attach remote",
    connect = function()
        local host = vim.fn.input("Host [127.0.0.1]: ")
        host = host ~= "" and host or "127.0.0.1"
        local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
        return {
            host = host,
            port = port
        }
    end
}}
dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "/home/arch/.local/share/nvim/mason/bin/OpenDebugAD7"
}
dap.configurations.cpp = {{
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true
}, {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    MIDebuggerServerAddress = "localhost:1234",
    MIDebuggerPath = "/home/arch/.local/share/nvim/mason/bin/OpenDebugAD7",
    cwd = "${workspaceFolder}",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end
}}
dap.configurations.c = dap.configurations.cpp

-- nvim 格式化
local util = require("formatter.util")

require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        html = {require("formatter.filetypes.html").htmlbeautifier, function()
            if util.get_current_buffer_file_name() == "special.lua" then
                return nil
            end
            return {
                exe = "standardjs"
            }
        end},
        javascript = {require("formatter.filetypes.javascript").standardjs, function()
            if util.get_current_buffer_file_name() == "special.lua" then
                return nil
            end
            return {
                exe = "standardjs"
            }
        end},
        java = {require("formatter.filetypes.java").clangformat, function()
            if util.get_current_buffer_file_name() == "special.lua" then
                return nil
            end
            return {
                exe = "clangformat"
            }
        end},
        python = {require("formatter.filetypes.python").black, function()
            if util.get_current_buffer_file_name() == "special.lua" then
                return nil
            end
            return {
                exe = "black"
            }
        end},
        lua = {require("formatter.filetypes.lua").stylua, function()
            if util.get_current_buffer_file_name() == "special.lua" then
                return nil
            end
            return {
                exe = "stylua",
                args = {"--search-parent-directories", "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()), "--", "-"},
                stdin = true
            }
        end},
        ["*"] = {require("formatter.filetypes.any").remove_trailing_whitespace}
    }
})
local lspsaga = require("lspsaga")
lspsaga.setup({
    debug = false,
    use_saga_diagnostic_sign = true,
    -- diagnostic sign
    error_sign = "",
    warn_sign = "",
    hint_sign = "",
    infor_sign = "",
    diagnostic_header_icon = "   ",
    -- code action title icon
    code_action_icon = " ",
    code_action_prompt = {
        enable = true,
        sign = true,
        sign_priority = 40,
        virtual_text = true
    },
    finder_definition_icon = "  ",
    finder_reference_icon = "  ",
    max_preview_lines = 10,
    finder_action_keys = {
        open = "o",
        vsplit = "s",
        split = "i",
        quit = "q",
        scroll_down = "<C-f>",
        scroll_up = "<C-b>"
    },
    code_action_keys = {
        quit = "q",
        exec = "<CR>"
    },
    rename_action_keys = {
        quit = "<C-c>",
        exec = "<CR>"
    },
    definition_preview_icon = "  ",
    border_style = "single",
    rename_prompt_prefix = "➤",
    rename_output_qflist = {
        enable = false,
        auto_open_qflist = false
    },
    server_filetype_map = {},
    diagnostic_prefix_format = "%d. ",
    diagnostic_message_format = "%m %c",
    highlight_prefix = false
})

local wk = require("which-key")
wk.register({
    d = {":Dashboard<CR>", "Dashboard"},
    e = {":NvimTreeToggle<CR>", "Explorer"},
    r = {":source<CR>", "Reload Neovim"},
    t = {":ToggleTerm<CR>", "Terminal"},
    q = {":q!<CR>", "Quit"},
    b = {
        name = "Tabs",
        p = {":BufferLineCyclePrev<CR>", "Prev"},
        n = {":BufferLineCycleNext<CR>", "Next"}
    },
    f = {
        name = "Telescope Find", -- 指定该快捷键组的名称
        b = {":Telescope buffers<CR>", "Buffers"},
        c = {":Telescope colorscheme<CR>", "Colorscheme"},
        C = {":Telescope commands<CR>", "Commands"},
        f = {":Telescope find_files<CR>", "Files"},
        g = {":Telescope live_grep<CR>", "Live Grep"},
        h = {":Telescope highlights<CR>", "Highlights"},
        H = {":Telescope help_tags<CR>", "Help Tags"},
        k = {":Telescope keymaps<CR>", "Keymaps"}
    },
    L = {
        name = "Lazy",
        c = {":Lazy clean<CR>", "Clean"},
        i = {":Lazy install<CR>", "Install"},
        r = {":Lazy reload<CR>", "Reload"},
        s = {":Lazy show<CR>", "Show"},
        u = {":Lazy update<CR>", "Update"}
    }

}, {
    prefix = "<leader>"
})


