-- Logique d'ouverture du projet
-- utilise telescope pour ouvrir un projet existant

local M = {}
local telescope = require('telescope.builtin')

local project_path = vim.fn.expand("~") .. "/Documents/DEVELOPPEMENT/PROJETS/"  -- Variable à modifier selon son propre système de fichiers

function M.open_project()
  telescope.find_files({
    prompt_title = "< Rechercher un projet >",
    cwd = project_path,
    hidden = true
  })
end

return M

