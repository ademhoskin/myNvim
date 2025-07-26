return {
  {
    "github/copilot.vim",
    config = function()
      -- Enable copilot for specific filetypes
      vim.g.copilot_filetypes = {
        ["*"] = false,
        python = true,
        javascript = true,
        typescript = true,
        lua = true,
        rust = true,
        go = true,
        c = true,
        cpp = true,
        nix = true,
        dockerfile = true,
      }
      
      -- Copilot keybindings
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
      
      vim.keymap.set('i', '<C-H>', '<Plug>(copilot-dismiss)')
      vim.keymap.set('i', '<C-L>', '<Plug>(copilot-next)')
      vim.keymap.set('i', '<C-K>', '<Plug>(copilot-previous)')
    end,
  },
}