return {
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
}
