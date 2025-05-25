{
    pkgs,
    lib,
    ...
}: {
    programs = {
        neovim = {
            enable = true;
            defaultEditor = true;
            extraLuaConfig = ''
                for opt, val in pairs {
                    clipboard = "unnamedplus",
                    termguicolors = true,
                    tabstop = 4,
                    shiftwidth = 4,
                    expandtab = true,
                    number = true,
                    cursorline = true,
                    shortmess = "IF",
                    showmode = false,
                    laststatus = 0
                } do
                    vim.opt[opt] = val
                end

                vim.g.mapleader = " " 
                local keymaps = { 
                    { mode = "n", bind = "<leader>f", cmd = function() require('snacks').picker.files() end, desc = "Find file" },
                    { mode = "n", bind = "<leader>r", cmd = function() require('snacks').picker.recent() end, desc = "Find recent file" },
                    { mode = "n", bind = "<leader>g", cmd = function() require('snacks').picker.grep() end, desc = "Find with grep" },
                }
                for _, keymap in ipairs(keymaps) do
                    vim.keymap.set(keymap.mode, keymap.bind, keymap.cmd, { desc = keymap.desc, noremap = true, silent = true })
                end
                local lsp_keymaps = {
                    { mode = "n", bind = "<leader>lr", cmd = function() require("live-rename").rename() end, desc = "LSP rename" },
                    { mode = "n", bind = "<leader>lh", cmd = function() vim.lsp.buf.hover() end, desc = "LSP hover" },
                    { mode = "n", bind = "<leader>ld", cmd = function() vim.lsp.buf.definition() end, desc = "LSP definition" },
                    { mode = "n", bind = "<leader>lo", cmd = function() vim.lsp.buf.declaration() end, desc = "LSP declaration" },
                    { mode = "n", bind = "<leader>lc", cmd = function() vim.lsp.buf.references() end, desc = "LSP references" },
                }
                for _, keymap in ipairs(lsp_keymaps) do
                    vim.api.nvim_create_autocmd("LspAttach", {
                        callback = function(event)
                            local bufnr = event.buf
                            vim.keymap.set(keymap.mode, keymap.bind, keymap.cmd, { desc = keymap.desc, buffer = bufnr, noremap = true, silent = true })
                        end
                    })
                end
            ''; 
            plugins = with pkgs; let
                mkFromGitHub = { owner, repo, rev, sha256 }: vimUtils.buildVimPlugin {
                    name = "${lib.strings.sanitizeDerivationName repo}";
                    src = fetchFromGitHub {
                        inherit owner repo rev sha256;
                    };
                };
                mkLuaType = configs: builtins.map (config: config // { type = "lua"; }) configs;
            in mkLuaType (with vimPlugins; [
                {
                    plugin = catppuccin-nvim;
                    config = ''
                        require("catppuccin").setup({
                            flavour = "frappe",
                        })
                        vim.cmd.colorscheme "catppuccin"
                    '';
                }
                {
                    plugin = nvim-treesitter.withPlugins (treesitter-plugins: with treesitter-plugins; [
		        go
                        c
                        cpp
                        zig
                        lua
                        python
                        javascript
                        typescript
                        css
                        scss
                        nix
                    ]);
                    config = ''
                        require'nvim-treesitter.configs'.setup({
                            auto_install = false,
                            highlight = {
                                enable = true
                            },
                            indent = {
                                enable = true
                            }
                        })       
                    '';
                }
                {
                    plugin = nvim-lspconfig;
                    config = ''
                        vim.diagnostic.config({
                            virtual_text = false,
                            virtual_lines = {
                                only_current_line = false,
                                format = function(diagnostic)
                                    local signs = {
                                        ERROR = " ",
                                        WARN = " ",
                                        INFO = " ",
                                        HINT = " "
                                    }
                                    return signs[vim.diagnostic.severity[diagnostic.severity]] .. diagnostic.message
                                end
                            },
                            signs = false
                        })
                        local servers = {
                            gopls = { },
                            clangd = { },
                            zls = { },
                            pyright = { },
                            lua_ls = {
                                settings = {
                                    Lua = {
                                        telemetry = {
                                            enable = false
                                        },
                                        workspace = {
                                            library = { },
                                            checkThirdParty = false
                                        }
                                    }
                                }
                            },
                            ts_ls = { },
                            cssls = { },
                            nil_ls = { }
                        }
                        for server, opts in pairs(servers) do
                            vim.lsp.config(server, opts)
                            vim.lsp.enable(server)
                        end 
                    '';
                }
                {
                    plugin = nvim-web-devicons;
                    config = ''
                        require'nvim-web-devicons'.setup()
                    '';
                }
                {
                    plugin = tiny-devicons-auto-colors-nvim;
                    config = ''
                        require('tiny-devicons-auto-colors').setup({
                            factors = {
                                lightness = 1.75,
                                chroma = 1,
                                hue = 1.25
                            },
                            precise_search = {
                                enabled = true,
                                iteration = 10,
                                precision = 20,
                                threshold = 23
                            },
                            cache = {
                                enabled = true
                            }
                        })
                    '';
                }
                {
                    plugin = mkFromGitHub {
                        owner = "saecki";
                        repo = "live-rename.nvim";
                        rev = "3fcc9dc66b3c32a9e312d40f41afab300f265a4b";
                        sha256 = "sha256-L0ViOLwvxYEyi1cbViFH520/GwTKxGHUEzmH0ulmK3U=";
                    };
                    config = ''
                        require("live-rename").setup({
                            keys = {
                                submit = {
                                    { "n", "<cr>" },
                                    { "v", "<cr>" },
                                    { "i", "<cr>" }
                                },
                                cancel = {
                                    { "n", "<esc>" }
                                }
                            }
                        })
                    '';
                }
                {
                    plugin = nvim-autopairs;
                    config = ''
                        require("nvim-autopairs").setup()
                    '';
                }
                {
                    plugin = mini-comment;
                    config = ''
                        require("mini.comment").setup({
                            mappings = {
                                comment = "",
                                comment_line = "<leader>cc",
                                comment_visual = "<leader>cs",
                                textobject = ""
                            }
                        })
                    '';
                }
                {
                    plugin = todo-comments-nvim;
                    config = ''
                        require("todo-comments").setup({
                            signs = false,
                            colors = {
                                green = {
                                    "#a6d189"
                                },
                                blue = {
                                    "#8caaee"
                                },
                                orange = {
                                    "#ef9f76"
                                },
                                gray = {
                                    "#9ca0b0"
                                },
                                red = {
                                    "#e78284"
                                }
                            },
                            keywords = {
                                DOCUMENT = {
                                    color = "green"
                                },
                                NOTE = {
                                    color = "blue"
                                },
                                OPTIMIZE = {
                                    color = "orange"
                                },
                                FIX = {
                                    color = "gray"
                                },
                                BUG = {
                                    color = "red"
                                }
                            },
                            merge_keywords = false,
                        })
                    '';
                }
                {
                    plugin = snacks-nvim;
                    config = ''
                        require("snacks").setup({
                            animate = {
                                fps = 60
                            },
                            bigfile = {
                                enabled = true
                            },
                            notifier = {
                                enabled = true,
                                style = "compact",
                                icons = {
                                    error = "",
                                    warn = "",
                                    info = "",
                                    debug = "󰃤",
                                    trace = ""
                                }
                            },
                            indent = {
                                enabled = true, 
                                scope = {
                                    enabled = true,
                                    only_current = false
                                },
                                chunk = {
                                    enabled = true,
                                    only_current = false,
                                    char = {
                                        corner_top = "╭",
                                        corner_bottom = "╰",
                                        arrow = ""
                                    }
                                },
                                animate = {
                                    enabled = true
                                }
                            },
                            picker = {
                                enabled = true,
                                prompt = " ❯ "
                            },
                        })
                    '';
                }
                {
                    plugin = noice-nvim;
                    config = ''
                        require("noice").setup({
                            lsp = {
                                override = {
                                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                                    ["vim.lsp.util.stylize_markdown"] = true
                                }
                            },
                            presets = {
                                bottom_search = false,
                                command_palette = true,
                                long_message_to_split = true,
                                lsp_doc_border = true
                            }
                        })
                    '';
                }
                {
                    plugin = which-key-nvim;
                    config = ''
                        require("which-key").setup({
                            preset = "helix"
                        })
                    '';
                }
                {
                    plugin = lualine-nvim;
                    config = ''
                        require('lualine').setup({
                            options = {
                                globalstatus = true,
                                section_separators = {
                                    left = "",
                                    right = ""
                                },
                                component_separators = {
                                    left = "",
                                    right = ""
                                },
                                theme = "catppuccin"
                            },
                            tabline = {
                                lualine_a = {
                                    {
                                        "buffers",
                                        show_filename_only = true,
                                        hide_filename_extension = true,
                                        mode = 0,
                                        use_mode_colors = true,
                                        buffers_color = {
                                            inactive = "lualine_b_normal"
                                        },
                                        symbols = {
                                            modified = " 󰛿",
                                            alternate_file = "",
                                            directory = "󰉋"
                                        },
                                        separator = {
                                            left = "",
                                            right = ""
                                        }
                                    }
                                }
                            },
                            sections = {
                                lualine_a = {
                                    {
                                        "mode",
                                        icon = "",
                                        separator = {
                                            left = "",
                                            right = ""
                                        }
                                    }
                                },
                                lualine_b = {
                                    {
                                        "branch",
                                        icon = "",
                                        separator = {
                                            left = "",
                                            right = ""
                                        }
                                    },
                                    {
                                        "diff",
                                        symbols = {
                                            added = "󰐗 ",
                                            modified = "󰛿 ",
                                            removed = "󰍶 "
                                        },
                                        separator = {
                                            left = "",
                                            right = ""
                                        }
                                    }
                                },
                                lualine_c = { },
                                lualine_x = { },
                                lualine_y = {
                                    {
                                        "diagnostics",
                                        symbols = {
                                            error = " ",
                                            warn = " ",
                                            info = " ",
                                            hint = " ",
                                        },
                                        separator = {
                                            left = "",
                                            right = ""
                                        }
                                    }
                                },
                                lualine_z = {
                                    {
                                        "location",
                                        icon = "",
                                        separator = {
                                            left = "",
                                            right = ""
                                        }
                                    }
                                }
                            },
                            inactive_sections = {
                                lualine_a = { },
                                lualine_b = { },
                                lualine_c = { },
                                lualine_x = { },
                                lualine_y = { },
                                lualine_z = { }
                            }
                        })
                    '';
                }
                friendly-snippets
                {
                    plugin = luasnip;
                    config = ''
                        require("luasnip.loaders.from_vscode").lazy_load()
                    '';
                }
                {
                    plugin = blink-cmp;
                    config = ''
                        require('blink.cmp').setup({
                            appearance = {
                                use_nvim_cmp_as_default = true,
                                nerd_font_variant = "mono"
                            },
                            completion = {
                                menu = {
                                    auto_show = true,
                                    draw = {
                                        columns = {
                                            { "label" },
                                            { "kind_icon", "kind", gap = 1 }
                                        },
                                        treesitter = {
                                            "lsp"
                                        }
                                    },
                                    border = "rounded",
                                    winhighlight = ""
                                },
                                list = {
                                    selection = {
                                        preselect = false,
                                        auto_insert = false
                                    }
                                },
                                documentation = {
                                    auto_show = true,
                                    window = {
                                        border = "rounded",
                                        winhighlight = ""
                                    }
                                },
                            },
                            signature = {
                                enabled = true,
                                window = {
                                    border = "rounded",
                                    winhighlight = ""
                                }
                            },
                            snippets = {
                                preset = "luasnip"
                            },
                            sources = {
                                default = {
                                    "lsp",
                                    "path",
                                    "snippets",
                                    "buffer"
                                }
                            },
                            keymap = {
                                preset = "none",
                                ["<C-c>"] = {
                                    "show",
                                    "hide"
                                },
                                ["<C-h>"] = {
                                    "show_documentation",
                                    "hide_documentation"
                                },
                                ["<C-s>"] = {
                                    "show_signature",
                                    "hide_signature"
                                },
                                ["<C-up>"] = {
                                    "select_prev"
                                },
                                ["<C-down>"] = {
                                    "select_next"
                                },
                                ["<C-left>"] = {
                                    "scroll_documentation_up"
                                },
                                ["<C-right>"] = {
                                    "scroll_documentation_down"
                                },
                                ["<C-a>"] = {
                                    "select_and_accept"
                                }
                            }
                        }) 
                    '';
                } 
            ]);
            extraPackages = with pkgs; [
                zig
                clang-tools
                zls
                lua-language-server
                pyright
                typescript-language-server
                vscode-langservers-extracted
                nil
            ];
        };
    };
}
