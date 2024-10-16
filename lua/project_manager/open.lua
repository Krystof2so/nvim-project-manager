-- ******************************************************
-- * open.lua                                           * 
-- *                                                    *  
-- * Gestion de l'ouverture d'un projet :               *
-- * - Utilise telescope pour ouvrir un projet existant *
-- ******************************************************


local M = {}
local telescope = require('telescope.builtin')

local project_path = vim.fn.expand("~") .. "/Documents/DEVELOPPEMENT/PROJETS/"  -- A modifier pour ouverture via liste de projets


-- **********************************
-- * Function to open project       *
-- * Fonction pour ouvrir un projet *
-- **********************************
function M.open_project()
  telescope.find_files({
    prompt_title = "< Rechercher un projet >",
    cwd = project_path,
    hidden = true
  })
end

return M

