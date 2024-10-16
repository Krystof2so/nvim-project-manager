-- plugin/project_manager.lua

-- Charge les modules nécessaires pour la création et l'ouverture de projets
local create = require('project_manager.create')
local open = require('project_manager.open')

-- Crée les commandes pour le plugin
-- Commande pour ouvrir un projet
vim.api.nvim_create_user_command('OpenProject', function()
    open.open_project()  -- Appelle la fonction pour ouvrir un projet
end, {})

-- Commande pour créer un projet
vim.api.nvim_create_user_command('CreateProject', function()
    create.create_project()  -- Appelle la fonction pour créer un projet
end, {})

-- Initialise et configure le plugin
-- Cette fonction sera appelée lors de la configuration du plugin
local function setup()
    -- Mapping pour appeler la fonction de création de projet avec <leader>cp
    vim.api.nvim_set_keymap('n', '<leader>cp', ':lua require("project_manager.create").create_project()<CR>', { noremap = true, silent = true })
end

-- Expose la fonction setup
return {
    setup = setup
}

