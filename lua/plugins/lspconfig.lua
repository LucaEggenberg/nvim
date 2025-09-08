return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', optional = true },
    { 'williamboman/mason-lsponfig.nvim', optional = true },
  },
  config = function()
    local lspconfig = require('lspconfig') 
    
    if vim.fn.executable("nix-store") == 1 then
      lspconfig.lua_ls.setup({
        cmd = { 'lua-language-server' },
      })
      lspconfig.qmlls.setup({
        cmd = { 'qmlls' },
      })
    else 
      require('mason').setup({
        ensure_installed = {
          'lua_ls',
          'qmlls',
        },
      })

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end
      })
    end

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
  end
}
