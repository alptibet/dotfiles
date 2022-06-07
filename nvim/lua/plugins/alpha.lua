local present, alpha = pcall(require, "alpha")
if not present then
  return
end

local dashboard = require("alpha.themes.dashboard")
local icons = require("icons")
local if_nil = vim.F.if_nil
local fn = vim.fn
local config_dir = fn.stdpath('config')

local header = {
" █████╗ ██╗     ██████╗     ████████╗██╗██████╗ ███████╗████████╗",
"██╔══██╗██║     ██╔══██╗    ╚══██╔══╝██║██╔══██╗██╔════╝╚══██╔══╝",
"███████║██║     ██████╔╝       ██║   ██║██████╔╝█████╗     ██║   ",
"██╔══██║██║     ██╔═══╝        ██║   ██║██╔══██╗██╔══╝     ██║   ",
"██║  ██║███████╗██║            ██║   ██║██████╔╝███████╗   ██║   ",
"╚═╝  ╚═╝╚══════╝╚═╝            ╚═╝   ╚═╝╚═════╝ ╚══════╝   ╚═╝   ",
}

dashboard.section.header.type = "text";
dashboard.section.header.val = header;
dashboard.section.header.opts = {
  position = "center",
}

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
