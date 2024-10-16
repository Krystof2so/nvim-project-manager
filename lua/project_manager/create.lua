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

-- *********************************************
-- * Fonction pour sélectionner un répertoire  *
-- * avec Telescope                           *
-- *********************************************
local function choose_directory_with_telescope(callback)
    telescope_builtin.find_files({
        prompt_title = "Sélectionnez un répertoire",
        cwd = vim.fn.getcwd(),
        find_command = { 'fd', '--type', 'd' },  -- Rechercher uniquement des répertoires
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            -- Quand l'utilisateur sélectionne un répertoire
            map('i', '<CR>', function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                if selection and selection.path then
                    callback(selection.path)  -- Exécute le callback avec le répertoire sélectionné
                else
                    vim.notify("Répertoire non valide.", vim.log.levels.ERROR)
                end
            end)

            return true
        end
    })
end

-- ******************************************
-- * Fonction pour saisir le nom du projet  *
-- * dans le terminal                      *
-- ******************************************
local function prompt_for_project_name()
    local project_name = vim.fn.input("Entrez le nom du projet: ")

    if project_name == "" then
        vim.notify("Nom du projet vide, opération annulée.", vim.log.levels.WARN)
        return nil
    end

    return project_name
end

-- ******************************************
-- * Fonction pour créer un nouveau projet  *
-- * en utilisant Telescope                *
-- ******************************************
function M.create_project_with_telescope()
    choose_directory_with_telescope(function(selected_directory)
        local project_name = prompt_for_project_name()

        if project_name then
            local project_path = selected_directory .. "/" .. project_name
            vim.fn.mkdir(project_path, "p")  -- Crée le répertoire du projet
            vim.notify("Projet créé dans : " .. project_path)
        end
    end)
end

return M

