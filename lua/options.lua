local opt = vim.opt
local glo = vim.g

opt.relativenumber = true
opt.cursorline = true
glo.mapleader = ' '

-- cursor always stays in its block shape
opt.guicursor = ''
opt.termguicolors = true

-- spaces > tabs because I want my code to look the same on any editor
opt.expandtab = true
opt.tabstop= 4
opt.shiftwidth = 4
opt.smartindent = true
opt.wrap = false

-- disable all mouse/touchpad activity to discourage usage
opt.mouse = ""
