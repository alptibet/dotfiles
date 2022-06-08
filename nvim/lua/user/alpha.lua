local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
local icons = require("user.icons")
local fn = vim.fn

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

local infoSection = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
if infoSection == nil then return end
local date = infoSection:read("*a")
infoSection:close()

local datetime = os.date " %H:%M"

local hi_top_section = {
  type = "text",
  val =  "┌────────────   Today is " .. date .. " ────────────┐",
  opts = {
    position = "center",
    hl = "HeaderInfo"
  }
}

local hi_middle_section = {
  type = "text",
  val = "│                                                │",
  opts = {
    position = "center",
    hl = "HeaderInfo"
  }
}

local hi_bottom_section = {
  type = "text",
  val = "└───══───══───══───  " .. datetime .. "  ───══───══───══────┘",
  opts = {
    position = "center",
    hl = "HeaderInfo"
  }
}

local section = {
  header = dashboard.section.header,
  hi_top_section = hi_top_section,
  hi_middle_section = hi_middle_section,
  hi_bottom_section = hi_bottom_section,
  buttons = dashboard.section.buttons,
}

local opts = {
  layout = {
    {type = "padding", val = 5},
    section.header,
    {type = "padding", val = 1},
    section.hi_top_section,
    section.hi_middle_section,
    section.hi_bottom_section,
    {type = "padding", val = 1},
    section.buttons,
  },
  opts = {
    margin = 5
  },
}
-- icons.fileNoBg .. " " .. "Find File"
dashboard.section.buttons.val = {
	dashboard.button("f", icons.telescope .. " " .. "Find Files" , ":Telescope find_files <CR>"),
	dashboard.button("e", icons.newFile .. " " .. "New File" ,  ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", icons.project .. " " .. "Find Project", ":Telescope projects <CR>"),
	dashboard.button("r", icons.fileRecent .. " " .. "Recent Files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", icons.text .. " " .. "Find Text", ":Telescope live_grep <CR>"),
	dashboard.button("q", icons.errorOutline .. " " .. "Quit", ":qa<CR>"),
}

alpha.setup(opts)

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
