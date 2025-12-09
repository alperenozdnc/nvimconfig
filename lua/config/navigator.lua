local keymap = require("utils").keymap

local term = require("harpoon.term")
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

keymap("n", "<leader>a", mark.add_file)
keymap("n", "<leader>m", ui.toggle_quick_menu)

keymap("n", "<leader>j", function()
	ui.nav_file(1)
end)
keymap("n", "<leader>k", function()
	ui.nav_file(2)
end)
keymap("n", "<leader>l", function()
	ui.nav_file(3)
end)
keymap("n", "<leader>;", function()
	ui.nav_file(4)
end)

keymap("n", "<leader>tj", function()
	term.gotoTerminal(1)
end)
keymap("n", "<leader>tk", function()
	term.gotoTerminal(2)
end)
