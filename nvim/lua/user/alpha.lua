local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
local icons = require("user.icons")
local if_nil = vim.F.if_nil
local fn = vim.fn
--Header
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
  hl = 'Primary'
}
--Info Section
local infoSection = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
if infoSection == nil then return end
local date = infoSection:read("*a")
infoSection:close()

local datetime = os.date " %H:%M"

local hi_top_section = {
  type = "text",
  val = "┌────────────   Today is " .. date .. " ────────────┐",
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
--Buttons
local leader = "SPC"
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

  local opts = {
    position = "center",
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = "right",
    hl = "Primary",
  }

  if keybind then
    keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { "n", sc_, keybind, keybind_opts }
  end

  local function on_press()
    -- local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
    local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
    vim.api.nvim_feedkeys(key, "t", false)
  end

  return {
    type = "button",
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

dashboard.section.buttons.val = {
  button("e", icons.newFile .. " " .. "New File", ":ene <BAR> startinsert <CR>", {}),
  button("f", icons.telescope .. " " .. "Find Files", ":Telescope find_files <CR>", {}),
  button("t", icons.text .. " " .. "Find Text", ":Telescope live_grep <CR>", {}),
  button("r", icons.fileRecent .. " " .. "Recent Files", ":Telescope oldfiles <CR>", {}),
  button("p", icons.project .. " " .. "Find Project", ":Telescope projects <CR>", {}),
  button("s", icons.timer .. " " .. "Load Session", ":SessionManager load_session<CR>", {}),
  button("q", icons.errorOutline .. " " .. "Quit", ":qa<CR>", {}),
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
    { type = "padding", val = 5 },
    section.header,
    { type = "padding", val = 1 },
    section.hi_top_section,
    section.hi_middle_section,
    section.hi_bottom_section,
    { type = "padding", val = 1 },
    section.buttons,
  },
  opts = {
    margin = 5
  },
}

alpha.setup(opts)

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
