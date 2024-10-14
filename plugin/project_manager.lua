-- Initialise et configure le plugin
-- Chargé par Neovim une fois installé
-- configure les commandes disponibles pour le plugin.

-- Charge le module principal
local project_manager = require('project_manager')

-- Commandes Neovim
vim.api.nvim_create_user_command('ProjectManagerCreate', project_manager.create_project, { nargs = 0 })
vim.api.nvim_create_user_command('ProjectManagerOpen', project_manager.open_project, { nargs = 0 })

