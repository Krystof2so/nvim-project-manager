-- Initialise et configure le plugin
-- Chargé par Neovim une fois installé
-- configure les commandes disponibles pour le plugin.

local M = require('project_manager.create')  -- Assure-toi que ce chemin est correct

-- Cette fonction sera appelée pour créer un projet
function M.setup()
    -- Mapping pour appeler la fonction de création de projet
    vim.api.nvim_set_keymap('n', '<leader>cp', ':lua require("project_manager.create").create_project()<CR>', { noremap = true, silent = true })
end

return M

