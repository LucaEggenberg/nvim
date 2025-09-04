  return {
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
}
