-- exit; go to explorer  
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {desc = 'exit; go to explorer'})

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- half page up/down with centered cursor 
vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc = 'half page down'})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc = 'half page up'})
