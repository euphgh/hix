require('Comment').setup()
-- hop {{{
require 'hop'.setup {}
-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirection

vim.keymap.set("", '<leader>hw', function()
        hop.hint_words()
end, { remap = true })

vim.keymap.set("", '<leader>hv', function()
        hop.hint_vertical()
end, { remap = true })

vim.keymap.set("", '<leader>hl', function()
        hop.hint_lines_skip_whitespace()
end, { remap = true })

vim.keymap.set("", 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })

vim.keymap.set("", 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })

vim.keymap.set("", 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })

vim.keymap.set({ "", "v" }, 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true }) --}}}
if vim.g.vscode then
else
        -- color theme {{{
        require('nightfox').setup({
                options = {
                        transparent = true,
                        styles = {
                                comments = "italic",
                                keywords = "bold",
                                types = "italic,bold",
                        }
                }
        })
        vim.g.nord_disable_background = true
        vim.cmd("colorscheme nord") -- }}}
        -- lualine{{{
        require('lualine').setup {
                options = {
                        icons_enabled = true,
                        theme = 'auto',
                },
                sections = {
                        lualine_c = { require('auto-session-library').current_session_name, '%f', vim.g['metals_status'] },
                },
        }
        -- }}}
        -- cmp {{{
        -- look {{{
        local cmp_kinds = {
                -- {{{
                Text = '  ',
                Method = '  ',
                Function = '  ',
                Constructor = '  ',
                Field = '  ',
                Variable = '  ',
                Class = '  ',
                Interface = '  ',
                Module = '  ',
                Property = '  ',
                Unit = '  ',
                Value = '  ',
                Enum = '  ',
                Keyword = '  ',
                Snippet = '  ',
                Color = '  ',
                File = '  ',
                Reference = '  ',
                Folder = '  ',
                EnumMember = '  ',
                Constant = '  ',
                Struct = '  ',
                Event = '  ',
                Operator = '  ',
                TypeParameter = '  ',
        } -- }}}
        -- VScode like{{{
        vim.cmd([[
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! link CmpItemKindInterface CmpItemKindVariable
highlight! link CmpItemKindText CmpItemKindVariable
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! link CmpItemKindMethod CmpItemKindFunction
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! link CmpItemKindProperty CmpItemKindKeyword
highlight! link CmpItemKindUnit CmpItemKindKeyword
]]) -- }}}
        -- }}}
        -- function {{{
        local cmp = require('cmp')
        -- nvim-autopairs {{{
        -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        -- cmp.event:on(
        --   'confirm_done',
        --   cmp_autopairs.on_confirm_done()
        -- )
        local npairs = require('nvim-autopairs')
        npairs.setup({
                fast_wrap = {
                        map = '<M-e>',
                        chars = { '{', '[', '(', '"', "'" },
                        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
                        end_key = '$',
                        keys = 'qwertyuiopzxcvbnmasdfghjkl',
                        check_comma = true,
                        highlight = 'Search',
                        highlight_grey = 'Comment'
                },
        })
        -- }}}
        -- luasnip {{{
        local luasnip = require("luasnip")
        local has_words_before = function() -- for mux <CR> between luasnip and cmp{{{
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end -- }}}
        vim.api.nvim_create_user_command('Snipedit', 'lua require("luasnip.loaders").edit_snippet_files({})', {})
        require("luasnip.loaders.from_vscode").lazy_load()
        -- }}}
        cmp.setup({
                -- {{{
                snippet = {
                        -- {{{
                        expand = function(args)
                                luasnip.lsp_expand(args.body)
                        end
                },          -- }}}
                sources = { -- {{{
                        { name = 'nvim_lsp' },
                        { name = 'buffer' },
                        { name = 'path' },
                        { name = 'luasnip', option = { show_autosnippets = true } },
                }, -- }}}
                mapping = cmp.mapping.preset.insert({
                        -- {{{
                        ["<CR>"] = cmp.mapping({
                                i = function(fallback)
                                        if cmp.visible() and cmp.get_active_entry() then
                                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                                        else
                                                fallback()
                                        end
                                end,
                                s = cmp.mapping.confirm({ select = true }),
                                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                        }),
                        ["<Tab>"] = cmp.mapping(function(fallback)
                                if cmp.visible() then
                                        cmp.select_next_item()
                                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                                        -- they way you will only jump inside the snippet region
                                elseif luasnip.expand_or_jumpable() then
                                        luasnip.expand_or_jump()
                                elseif has_words_before() then
                                        cmp.complete()
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
                }), -- }}}
                -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).{{{
                -- cmp.setup.cmdline({ '/', '?' }, {
                -- 	mapping = cmp.mapping.preset.cmdline(),
                -- 	sources = {
                -- 		{ name = 'buffer' }
                -- 	}
                -- }),
                cmp.setup.cmdline(':', {
                        mapping = cmp.mapping.preset.cmdline(),
                        sources = cmp.config.sources(
                                { { name = 'path' } },
                                { {
                                        name = 'cmdline',
                                        option = {
                                                ignore_cmds = {
                                                        'Man', '!', 'edit',
                                                        'qall', 'quit',
                                                        "write", "wall", "wqall", "w", "wq"
                                                }
                                        }
                                } })
                }), -- }}}
                formatting = {
                        -- {{{
                        format = function(_, vim_item)
                                vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
                                return vim_item
                        end,
                }, -- }}}
        })         -- }}}
        -- }}}
        -- }}}
        -- bufferline{{{
        vim.opt.termguicolors = true
        local nord_hl = require("nord").bufferline.highlights({
                italic = true,
                bold = true,
                fill = "#181c24"
        })

        require("bufferline").setup({
                options = {
                        separator_style = "slant",
                },
                highlights = nord_hl,
        })
        --}}}
        -- auto session{{{
        require('auto-session').setup({
                auto_session_create_enabled = false,
                auto_save_enabled = true,
                auto_restore_enabled = true,
        })
        vim.o.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize,winpos" -- }}}
        -- symbols outline {{{
        local opts = {
                highlight_hovered_item = true,
                show_guides = true,
                auto_preview = false,
                position = 'right',
                relative_width = true,
                width = 25,
                auto_close = false,
                show_numbers = false,
                show_relative_numbers = false,
                show_symbol_details = true,
                preview_bg_highlight = 'Pmenu',
                autofold_depth = nil,
                auto_unfold_hover = true,
                fold_markers = { '', '' },
                wrap = false,
                keymaps = {
                        -- These keymaps can be a string or a table for multiple keys
                        close = { "<Esc>", "q" },
                        goto_location = "<Cr>",
                        focus_location = "o",
                        hover_symbol = "<C-space>",
                        toggle_preview = "K",
                        rename_symbol = "r",
                        code_actions = "a",
                        fold = "h",
                        unfold = "l",
                        fold_all = "W",
                        unfold_all = "E",
                        fold_reset = "R",
                },
                lsp_blacklist = {},
                symbol_blacklist = {},
                symbols = {
                        File = { icon = "", hl = "@text.uri" },
                        Module = { icon = "", hl = "@namespace" },
                        Namespace = { icon = "", hl = "@namespace" },
                        Package = { icon = "", hl = "@namespace" },
                        Class = { icon = "𝓒", hl = "@type" },
                        Method = { icon = "ƒ", hl = "@method" },
                        Property = { icon = "", hl = "@method" },
                        Field = { icon = "", hl = "@field" },
                        Constructor = { icon = "", hl = "@constructor" },
                        Enum = { icon = "ℰ", hl = "@type" },
                        Interface = { icon = "ﰮ", hl = "@type" },
                        Function = { icon = "", hl = "@function" },
                        Variable = { icon = "", hl = "@constant" },
                        Constant = { icon = "", hl = "@constant" },
                        String = { icon = "𝓐", hl = "@string" },
                        Number = { icon = "#", hl = "@number" },
                        Boolean = { icon = "⊨", hl = "@boolean" },
                        Array = { icon = "", hl = "@constant" },
                        Object = { icon = "⦿", hl = "@type" },
                        Key = { icon = "🔐", hl = "@type" },
                        Null = { icon = "NULL", hl = "@type" },
                        EnumMember = { icon = "", hl = "@field" },
                        Struct = { icon = "𝓢", hl = "@type" },
                        Event = { icon = "🗲", hl = "@type" },
                        Operator = { icon = "+", hl = "@operator" },
                        TypeParameter = { icon = "𝙏", hl = "@parameter" },
                        Component = { icon = "", hl = "@function" },
                        Fragment = { icon = "", hl = "@constant" },
                },
        }
        require("symbols-outline").setup(opts) -- }}}
        require("todo-comments").setup {}
        require("lsp")
-- nvim-treesitter{{{
require 'nvim-treesitter.configs'.setup {
        sync_install = false,
        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
                -- `false` will disable the whole extension
                enable = true,
                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,
                -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                disable = 'help',
        },
        rainbow = {
                enable = true,
                -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil, -- Do not enable for files with more than n lines, int
                -- colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
        }
}
vim.cmd([[
autocmd BufReadPost * TSDisable rainbow | TSEnable rainbow
]])
-- }}}
--telescope{{{
require('telescope').load_extension('fzf')
local builtin = require('telescope.builtin')
function vim.getVisualSelection()
        vim.cmd('noau normal! "vy"')
        local text = vim.fn.getreg('v')
        vim.fn.setreg('v', {})

        text = string.gsub(text, "\n", "")
        if #text > 0 then
                return text
        else
                return ''
        end
end

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>cf', builtin.grep_string, {})
vim.keymap.set('v', '<leader>cf', function()
        builtin.grep_string({ default_text = vim.getVisualSelection() })
end, {})
vim.keymap.set('n', '<leader>mc', require "telescope".extensions.metals.commands, {})
vim.cmd("nnoremap <leader>lg :Telescope live_grep<CR>")
--}}}
end
