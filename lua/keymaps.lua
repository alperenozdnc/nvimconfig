local keymap = require("utils").keymap

-- disable all mouse/touchpad activity to discourage usage
keymap("", "<up>", "<nop>")
keymap("", "<down>", "<nop>")
keymap("i", "<up>", "<nop>")
keymap("i", "<down>", "<nop>")

-- huge life improvement not having to ctrl-c out of insert mode
keymap("i", "jj", "<ESC>")

-- nice little touches to make configuring easier
local function cfgload()
	vim.cmd(":so %")
	print("> cfg load success")
end

local function cfgedit()
	vim.cmd(":e ~/.config/nvim/init.lua")
	Chroot()
	vim.cmd(":e ~/.config/nvim")

	print("> editing cfg")
end

keymap("n", "<leader>ce", cfgedit)
keymap("n", "<leader>ss", cfgload)

-- whos going to write :w and :q every time?
keymap("n", "<leader>w", function()
	local clients = vim.lsp.get_clients()

	for _, client in ipairs(clients) do
		if client.server_capabilities.documentFormattingProvider then
			vim.lsp.buf.format({ async = false })
			vim.cmd.write()

			return
		end
	end

	vim.cmd.write()
end)

keymap("n", "<leader>q", ":q<CR>")
keymap("n", "<leader>fq", ":q!<CR>")

-- feels nice to jump around
local function mv_vert(dir)
	local height = (tonumber(vim.api.nvim_exec2("echo &lines", { output = true }).output) or 0)
	local mv_distance = math.floor(height / 8)

	return string.format("%d%s", mv_distance, dir)
end

local function mv_horiz(dir)
	local width = (tonumber(vim.api.nvim_exec2("echo &columns", { output = true }).output) or 0)
	local mv_distance = math.floor(width / 8)

	return string.format("%d%s", mv_distance, dir)
end

keymap("n", "<c-j>", mv_vert("j"))
keymap("n", "<c-k>", mv_vert("k"))
keymap("n", "<c-h>", mv_horiz("h"))
keymap("n", "<c-l>", mv_horiz("l"))

-- easy indentation
keymap("v", "<Tab>", ">gv")
keymap("v", "<S-Tab>", "<gv")
keymap("v", "eq", "=gv")

-- copy to clipboard
local function cp()
	local has_clipboard = vim.fn.has("clipboard")

	if has_clipboard == 0 then
		print("> no clipboard provider")
	else
		-- "+ is the clipboard register
		vim.api.nvim_feedkeys('"+y', "v", true)
	end
end

keymap("v", "<leader>y", cp)

-- nice for moving lines
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- remove annoying highlight after searches
keymap("n", "<leader>nh", ":noh<CR>", { silent = true })

-- these are really useful for scripting
local function executable()
	vim.cmd(":!chmod +x %")
	print("> file = executable")
end

local function non_executable()
	vim.cmd(":!chmod -x %")
	print("> file = not executable")
end

keymap("n", "<leader>xx", executable)
keymap("n", "<leader>ux", non_executable)

-- terminals + harpoon is op
keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- make telescope search not annoying after directory change
function Chroot()
	local cwd = vim.fn.expand("%:p:h")

	vim.api.nvim_set_current_dir(cwd)

	print(string.format("> cwd is %s", cwd))
end

keymap("n", "<leader>root", Chroot)
