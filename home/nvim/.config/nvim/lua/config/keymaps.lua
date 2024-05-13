-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Add keybind to toggle copilot
vim.g.copilot_enabled = false
vim.keymap.set({ "n", "v" }, "<leader>cp", function()
  if vim.g.copilot_enabled then
    vim.cmd("Copilot disable")
    print("Copilot disabled")
  else
    vim.cmd("Copilot enable")
    print("Copilot enabled")
  end
  vim.g.copilot_enabled = not vim.g.copilot_enabled
end, { desc = "Toggle Copilot" })
