--======== language protocol server configure ========--

-- lsp keymap {{{lspinit
local api = vim.api
local map = vim.keymap.set
----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

-- LSP mappings
local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
end

map("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end)

-- map("n", "<leader>ws", function()
--   require("metals").hover_worksheet()
-- end)

-- all workspace diagnostics
map("n", "<leader>cd", function()
	vim.diagnostic.setqflist()
end)
-- buffer diagnostics only
map("n", "<leader>ld", function()
	vim.diagnostic.setloclist()
end)
map("n", "[w", function()
	vim.diagnostic.goto_prev({ wrap = false })
end)
map("n", "]w", function()
	vim.diagnostic.goto_next({ wrap = false })
end)
local lspconfig = require("lspconfig")
local lsp_flags = {
	debounce_text_changes = 100,
}
-- }}}

-- Setup lspconfig to cmp.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- start server
lspconfig.lua_ls.setup { -- {{{
	flags = lsp_flags,
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { "vim", "packer_bootstrap" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
}                         -- }}}
lspconfig.pyright.setup { -- {{{
	flags = lsp_flags,
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
				typeCheckingMode = "off",
			}
		}
	},
} -- }}}
-- metals for scala{{{
local metals_config = require("metals").bare_config()
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}
metals_config.init_options.statusBarProvider = "on" --状态栏展示metals_status
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})-- }}}
require 'lspconfig'.clangd.setup { -- {{{
	flags = lsp_flags,
	capabilities = capabilities,
	on_attach = on_attach,
}                              -- }}}
require 'lspconfig'.svls.setup { -- {{{
	flags = lsp_flags,
	capabilities = capabilities,
	on_attach = on_attach,
}                              -- }}}
require 'lspconfig'.sqlls.setup { -- {{{
	flags = lsp_flags,
	capabilities = capabilities,
	on_attach = on_attach,
}                              -- }}}
require 'lspconfig'.rnix.setup { -- {{{
	flags = lsp_flags,
	capabilities = capabilities,
	on_attach = on_attach,
} -- }}}
require 'lspconfig'.texlab.setup {-- {{{
	flags = lsp_flags,
	capabilities = capabilities,
	on_attach = on_attach,
}-- }}}
require'lspconfig'.marksman.setup{}
