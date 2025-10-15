return {
  "github/copilot.vim",
  config = function()
    vim.keymap.set("i", "<C-j>", 'copilot#Accept("")', {
      expr = true,
      replace_keycodes = false,
      desc = "Accept Copilot suggestion",
    })
    vim.g.copilot_no_tab_map = true
  end,
}
