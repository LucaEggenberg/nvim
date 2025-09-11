return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig') 
    local default_opts = { noremap = true, silent = true }
    
    local on_attach = function(client, bufnr)
      map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', default_opts)
      map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', default_opts)
      map('n', 'gr', ':Telescope lsp_references<CR>', default_opts)
      map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', default_opts)
      map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', default_opts)
      map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', default_opts)
      map('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', default_opts)
      map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', default_opts)
      map('n', '<leader>D', ':Telescope diagnostics<CR>', default_opts)
      map('n', '<leader>f', ':lua vim.lsp.buf.format()<CR>', default_opts)
      map('n', '[d', ':lua vim.diagnostics.goto_prev()<CR>', default_opts)
      map('n', ']d', ':lua vim.diagnostic.got_next()<CR>', default_opts)
    end 
    
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
    })
    lspconfig.nixd.setup({
      on_attach = on_attach,
    })

    if vim.fn.getenv('NVIM_CSHARP_LS') then
      lspconfig.omnisharp.setup({
        on_attach = on_attach,
      })
    end

    if vim.fn.getenv('NVIM_QML_LS') then
      lspconfig.qmlls.setup({
        cmd = { 'qmlls' },
      })
    end
  end
}
