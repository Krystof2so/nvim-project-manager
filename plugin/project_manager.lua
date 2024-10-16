-- Initialise et configure le plugin
-- Chargé par Neovim une fois installé
-- configure les commandes disponibles pour le plugin.


-- Ajouter une commande pour créer un projet avec Telescope
vim.api.nvim_create_user_command(
    'CreateProject',
    function() require('project_manager.create').create_project_with_telescope() end,
    { desc = 'Créer un projet via Telescope' }
)

