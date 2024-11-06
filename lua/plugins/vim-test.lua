return {
  "vim-test/vim-test",
  config = function()
    vim.keymap.set("n", "<leader>tf", ":TestFile<cr>", { silent = true, desc = "Tests: Current file" })
    vim.keymap.set("n", "<leader>tn", ":TestNearest<cr>", { silent = true, desc = "Tests: Nearest method"})
  end,
}
