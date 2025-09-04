return {
  { 
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      vim.cmd.colorscheme('catppuccin-frappe')
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
   
    tag = '0.1.8',
   
    dependencices = { 
      'nvim-lua/plenary.nvim'
    },
   
    config = function()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'find text in files' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'find buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'find help tags' })
    end,
  },
  {
    'ThePrimeagen/harpoon',
    config = function()
      local mark = require('harpoon.mark')
      local ui = require('harpoon.ui')

      vim.keymap.set('n', '<leader>H', mark.add_file, { desc = 'harpoon file' })
      vim.keymap.set('n', '<leader>h', ui.toggle_quick_menu, { desc = 'harpoon quick menu' })
      for i = 1, 5 do
        vim.keymap.set('n', '<leader' .. i, function() ui.nav_file(i) end, { desc = 'harpoon to file' .. i })
      end
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup({})

      vim.keymap.set('n', '<leader>e', require('nvim-tree.api').tree.toggle, { desc = 'toggle file tree' })
    end,
  }
}
