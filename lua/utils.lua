local utils = {}

function utils.keymap(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end

return utils
