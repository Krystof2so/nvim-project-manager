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

-- Fonction pour créer un nouveau projet dans un répertoire sélectionné via Telescope
function M.create_project_with_telescope()
    -- Utiliser Telescope pour choisir le répertoire cible
    require('telescope.builtin').find_files({
        prompt_title = "Choisissez le répertoire cible",
        cwd = vim.fn.expand("~"),  -- Commence dans le répertoire home
        find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" }, -- Limite la recherche aux répertoires
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            -- Fonction pour confirmer la sélection et créer un sous-répertoire
            local function confirm_selection()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                -- Obtenir le chemin sélectionné
                local selected_directory = selection.path or selection[1]

                -- Demander le nom du projet
                local project_name = vim.fn.input("Nom du projet: ")

                if project_name == "" then
                    vim.notify("Nom du projet non spécifié, opération annulée.", vim.log.levels.WARN)
                    return
                end

                -- Construire le chemin complet du nouveau répertoire
                local project_path = selected_directory .. "/" .. project_name

                -- Créer le répertoire
                vim.fn.mkdir(project_path, "p")
                vim.notify("Projet créé dans : " .. project_path)
            end

            -- Mapper la touche Enter pour confirmer la sélection
            map('i', '<CR>', confirm_selection)
            map('n', '<CR>', confirm_selection)

            return true
        end
    })
end

return M

