local keymap = require("utils").keymap

keymap("n", "mdt", ":Markview Toggle<CR>", { silent = true })
keymap("n", "mds", ":Markview splitToggle<CR>", { silent = true })
