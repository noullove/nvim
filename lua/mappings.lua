require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

-- restore cursor position
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- dynamic terminal padding
autocmd("VimEnter", {
  command = ":silent !kitty @ set-spacing padding=0 margin=0",
})

autocmd("VimLeavePre", {
  command = ":silent !kitty @ set-spacing padding=20 margin=10",
})

-- keymap
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>lm", function()
  require("telescope.builtin").lsp_document_symbols({ symbols = { "class", "method", "function" } })
end, { desc = "LSP document symbols" } )
map("n", "<leader>cd", require("telescope").extensions.zoxide.list, { desc = "Telescope zoxide list" })

-- volt menu
-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- volt menu
-- mouse users + nvimtree users!
vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
  require('menu.utils').delete_old_menus()

  vim.cmd.exec '"normal! \\<RightMouse>"'

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

  require("menu").open(options, { mouse = true })
end, {})
