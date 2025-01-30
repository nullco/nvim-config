return {
  "vim-test/vim-test",
  config = function()
    vim.keymap.set("n", "<leader>tf", ":TestFile<cr>", { silent = true, desc = "Tests: current [f]ile" })
    vim.keymap.set("n", "<leader>tc", ":TestClass<cr>", { silent = true, desc = "Tests: nearest [c]lass" })
    vim.keymap.set("n", "<leader>tm", ":TestNearest<cr>", { silent = true, desc = "Tests: nearest [m]ethod"})
    vim.keymap.set("n", "<leader>tl", ":TestLast<cr>", { silent = true, desc = "Tests: re-run [l]ast test again" })
  end,
}
