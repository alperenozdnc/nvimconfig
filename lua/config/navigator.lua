local keymap = require("utils").keymap
local harpoon = require("harpoon")

harpoon:setup({})

keymap("n", "<leader>a", function()
	harpoon:list():add()
end)

keymap("n", "<leader>m", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

keymap("n", "<leader>j", function()
	harpoon:list():select(1)
end)
keymap("n", "<leader>k", function()
	harpoon:list():select(2)
end)
keymap("n", "<leader>l", function()
	harpoon:list():select(3)
end)
keymap("n", "<leader>;", function()
	harpoon:list():select(4)
end)

local term_list = harpoon:list("terms")

local function select_term(index)
	if index > term_list:length() then
		vim.cmd("terminal")
		term_list:add()
	else
		term_list:select(index)
	end
end

keymap("n", "<leader>tj", function()
	select_term(1)
end)
keymap("n", "<leader>tk", function()
	select_term(2)
end)
