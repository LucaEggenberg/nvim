return {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require('notify')

    notify.setup({
      stages = "fade_in_slide_out",
      render = "compact",
      timeout = 2500,
      background_color = "#000000",
      fps = 60,
      top_down = true,
    })

    vim.notify = notify
  end,
}
