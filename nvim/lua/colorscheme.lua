local present, tk_colors = pcall(require, "tokyonight.colors")
if not present then
  return
end

vim.cmd('colorscheme tokyonight')
-- Tokyonight config
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_colors = {
  border = '#1A1B26';
}
