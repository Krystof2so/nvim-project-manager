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
local Path = require('plenary.path')

-- *********************************************
-- * Fonction pour lister les répertoires    *
-- * dans un chemin donné                     *
-- *********************************************
local function list_directories(path)
    local directories = {}
    local dir_path = Path:new(path)

    for _, entry in ipairs(vim.fn.readdir(dir_path:absolute())) do
        local entry_path = dir_path / entry
        if vim.fn.isdirectory(entry_path) == 1 then
            table.insert(directories, entry)
        end
    end

    return directories
end

-- *********************************************
-- * Fonction pour choisir un répertoire      *
-- * avec autocomplétion                      *
-- *********************************************
local function choose_directory_with_completion()
    local current_dir = vim.fn.getcwd()

    -- Liste des répertoires pour l'autocomplétion
    local directories = list_directories(current_dir)

    -- Saisir le nom du répertoire avec autocomplétion
    local opts = {
        prompt_title = "Choisir un répertoire",
        default_text = current_dir,
        complete_fn = function(_, _, _, input)
            -- Filtrer les répertoires en fonction de l'entrée de l'utilisateur
            return vim.tbl_filter(function(dir)
                return dir:match(input) -- Correspondance avec l'entrée
            end, directories)
        end,
    }

    return vim.fn.inputlist({ "Entrez le chemin du répertoire (ou sélectionnez un répertoire): ", unpack(directories) })
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
-- * en utilisant l'autocomplétion         *
-- ******************************************
function M.create_project_with_completion()
    local selected_directory = choose_directory_with_completion()

    if selected_directory == nil or selected_directory == 0 then
        vim.notify("Aucun répertoire sélectionné, opération annulée.", vim.log.levels.WARN)
        return
    end

    local project_name = prompt_for_project_name()

    if project_name then
        local project_path = selected_directory .. "/" .. project_name
        vim.fn.mkdir(project_path, "p")  -- Crée le répertoire du projet
        vim.notify("Projet créé dans : " .. project_path)
    end
end

return M

