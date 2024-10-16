-- Point d'entrée du plugin
-- Va charger les fonctionnalités depuis les autres fichiers Lua.

local create = require("project_manager.create")
local open = require("project_manager.open")

local M = {}

-- Importation des fonctions
M.create_project = create.create_project_with_telescope
M.open_project = open.open_project

return M

