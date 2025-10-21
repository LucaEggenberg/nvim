return {
  'neovim/nvim-lspconfig',
  config = function()
    local default_opts = { noremap = true, silent = true }

    local function map_buf(bufnr, mode, lhs, rhs)
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, default_opts)
    end
    
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user.lsp", {}),
      callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        map_buf(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
        map_buf(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
        map_buf(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>")
        map_buf(bufnr, "n", "K",  "<cmd>lua vim.lsp.buf.hover()<CR>")
        map_buf(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
        map_buf(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
        map_buf(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
        map_buf(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
        map_buf(bufnr, "n", "<leader>D", "<cmd>Telescope diagnostics<CR>")
        map_buf(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>")
        map_buf(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
        map_buf(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
      end,
    })

    local detected_lsps = {}

    local function setup_if_present(server, opts)
      local bin = opts and opts.bin or server
      if vim.fn.executable(bin) == 1 then
        vim.lsp.config(server, opts or {}) 
        vim.lsp.enable(server)
        table.insert(detected_lsps, server)
      end
    end

    setup_if_present('lua_ls', {
      bin = 'lua-language-server',
      settings = {
        Lua = { diagnostics = { globals = { 'vim' } } },
      },
    })

    setup_if_present('nixd')
    setup_if_present('omnisharp')
    setup_if_present('qmlls')

    if #detected_lsps > 0 then
      vim.schedule(function()
        vim.notify("LSPs detected: " .. table.concat(detected_lsps, ", "), vim.log.levels.INFO, { title = "LSP" })
      end)
    else
      vim.schedule(function()
        vim.notify("No LSP servers detected in PATH", vim.log.levels.WARN, { title = "LSP" })
      end)
    end
  end
}
