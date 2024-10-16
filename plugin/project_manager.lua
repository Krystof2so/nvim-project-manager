-- Initialise et configure le plugin
-- Chargé par Neovim une fois installé
-- configure les commandes disponibles pour le plugin.

-- Charge le module principal
local project_manager = require('project_manager')

-- Ajouter une commande pour créer un projet avec Telescope
vim.api.nvim_create_user_command(
    'CreateProjectWithTelescope',
    function()
        project_manager.create_project_with_telescope()
    end,
    {}
)

