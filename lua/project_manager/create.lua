-- *************************************************************************
-- * create.lua                                                            *
-- *                                                                       *
-- * Manages project creation:                                             *
-- * - Users choose the directory where the project will be created        *
-- * --------------------------------------------------------------------- *
-- * Gère la création de projet :                                          *
-- * - L'utilisateur choisit lui-même le répertoire où le projet sera créé *
-- *************************************************************************

local M = {}
local telescope_builtin = require('telescope.builtin')
local action_state = require('telescope.actions.state')

-- Fonction pour choisir un répertoire avec Telescope
local function choose_directory(callback)
    telescope_builtin.file_browser({
        prompt_title = "Choisissez un répertoire",
        cwd = os.getenv("HOME"),  -- Ouvre Telescope dans le répertoire personnel
				hidden = true, -- Affiche les dossiers et fichiers cachés
        attach_mappings = function(prompt_bufnr, map)
            -- Mappage pour sélectionner un répertoire
            map('i', '<CR>', function()
                local selection = action_state.get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)
                if selection then
                    callback(selection.path)  -- Passer le chemin sélectionné
                end
            end)
            return true
        end,
    })
end

-- Fonction pour demander le nom du projet
local function prompt_for_project_name()
    local project_name = vim.fn.input("Entrez le nom du projet: ")
    if project_name == "" then
        vim.notify("Nom du projet vide, opération annulée.", vim.log.levels.WARN)
        return nil
    end
    return project_name
end

-- Fonction pour créer un projet
function M.create_project()
    choose_directory(function(selected_directory)
        local project_name = prompt_for_project_name()
        if project_name then
            local project_path = selected_directory .. "/" .. project_name
            vim.fn.mkdir(project_path, "p")  -- Crée le répertoire
            vim.notify("Projet créé dans : " .. project_path)
        end
    end)
end

return M

