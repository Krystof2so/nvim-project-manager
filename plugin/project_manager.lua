-- Initialise et configure le plugin
-- Chargé par Neovim une fois installé
-- configure les commandes disponibles pour le plugin.

-- Charge le module principal
local project_manager = require('project_manager')

-- Commandes Neovim pour créer et ouvrir un projet :
vim.api.nvim_create_user_command('ProjectManagerCreate', project_manager.create_project, { nargs = 0 })
vim.api.nvim_create_user_command('ProjectManagerOpen', project_manager.open_project, { nargs = 0 })

-- Configuration des keymaps
vim.api.nvim_set_keymap('n', '<leader>cp', ':CreateProject<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>op', ':OpenProject<CR>', { noremap = true, silent = true })

