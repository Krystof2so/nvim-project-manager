-- Point d'entrée du plugin
-- Va charger les fonctionnalités depuis les autres fichiers Lua.

local M = {}

-- Importation des fonctions
M.create_project = require('project_manager.create').create_project
M.open_project = require('project_manager.open').open_project

return M

