-- *************************************************************************
-- * create.lua                                                            *
-- *                                                                       *
-- Manages project creation:                                               *
-- * - Users choose the directory where the project will be created        *
-- * --------------------------------------------------------------------- *
-- * Gère la création de projet :                                          *
-- * - L'utilisateur choisit lui-même le répertoire où le projet sera créé *
-- *************************************************************************

local M = {}

local project_path = vim.fn.expand("~") .. "/Documents/DEVELOPPEMENT/PROJETS/"  -- Variable à modifier selon son propre système de fichiers


-- **********************************************************
-- * Function to choice repertory to create project         *
-- * Fonction pour choisir le répertoire où créer le projet *
-- **********************************************************
local function prompt_for_project_directory()
    local project_directory = vim.fn.input(
		"Entrez le chemin du répertoire où enregistrer le projet: ", vim.fn.getcwd(), "dir"
	)
    if project_directory == "" then
        vim.notify("Aucun répertoire spécifié, opération annulée.", vim.log.levels.WARN)
        return nil
    end
    return project_directory
end


-- *****************************************
-- * Function to create a new project      *
-- * Fonction pour créer un nouveau projet *
-- *****************************************
function M.create_project()
	local project_directory = prompt_for_project_directory()
	if project_directory then
        vim.fn.mkdir(project_directory, "p") -- Crée le répertoire s'il n'existe pas
        vim.notify("Projet créé dans : " .. project_directory)
        -- Ajouter ici toute autre logique spécifique pour initialiser le projet
    end
  --vim.ui.input({ prompt = 'Nom du projet à créer: ' }, function(input)
    --if input ~= nil then  -- PREVOIR SI SAISIE DE CARACTERES SPECIAUX
      --local new_project_dir = project_path .. input
      --os.execute("mkdir -p " .. new_project_dir)
      --print("Projet créé : " .. new_project_dir)
      -- Optionnel : ouvre automatiquement nvim-tree dans le projet
      --vim.cmd('cd ' .. new_project_dir)
      --vim.cmd('NvimTreeOpen')
    --end
end

return M

