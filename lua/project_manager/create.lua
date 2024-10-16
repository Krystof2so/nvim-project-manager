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
local popup = require('popup')


-- ******************************************************
-- * Function to create popup :                         *
-- * - displays directory path entry prompt             *
-- * -------------------------------------------------- *
-- * Fonction pour créer un popup :                     *
-- * - affiche prompt de saisie de chemin de répertoire *
-- ******************************************************
function M.create_popup(title, prompt, confirm_fn, close_fn)
    local buf = vim.api.nvim_create_buf(false, true) -- Prépare un buffer pour afficher le popup 
		-- Utilisation de l'API moderne pour définir les options du buffer :
    vim.bo[buf].buftype = 'nofile'   -- Le buffer n'est pas lié à un fichier
    vim.bo[buf].bufhidden = 'wipe'   -- Supprimer le buffer de la mémoire une fois fermé
    local opts = {
        title = title,
        border = "single",
        relative = "editor",
        width = 40,
        height = 5,
        row = math.ceil((vim.o.lines - 5) / 2),
        col = math.ceil((vim.o.columns - 40) / 2),
    }

    -- Ouvrir le popup :
    vim.api.nvim_open_win(buf, true, opts)

    -- Insérer le message d'invite :
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {prompt, "", ""})

    -- Mappage des touches :
		-- Touche pour appeler la fonction confirm_input() :
    vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', string.format('<cmd>lua require("project_manager.create").%s()<CR>', confirm_fn), { noremap = true, silent = true })
		-- Touche pour appelr la fonction close_popup() :
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', string.format('<cmd>lua require("project_manager.create").%s()<CR>', close_fn), { noremap = true, silent = true })
end


-- ************************************************************
-- * Function to confirm input :                              *
-- * - Create project directory                               *
-- * - Confirms the creation of this directory with a message *
-- * - Create repertory and dsplay confirmation               *
-- * -------------------------------------------------------- *
-- * Fonction pour confirmer l'entrée utilisateur :           *
-- * - Crée répertoire du projet                              *
-- * - Confirme la création de ce répertoire par un message   *
-- ************************************************************
function M.confirm_input()
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 1, 2, false) -- Obtenir la ligne de saisie
    local project_directory = lines[1] or ""

    if project_directory == "" then
        vim.notify("Aucun répertoire spécifié, opération annulée.", vim.log.levels.WARN)
        M.close_popup()
        return
    end

    -- Créer le répertoire s'il n'existe pas :
    vim.fn.mkdir(project_directory, "p")
    vim.notify("Projet créé dans : " .. project_directory)
    M.close_popup() -- Fermer le popup après création
end


-- *********************************
-- * Function to close popup       *
-- * Fonction pour fermer le popup *
-- *********************************
function M.close_popup()
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_close(win, true)
end


-- *********************************
-- * Function to create project    *
-- * Fonction pour créer un projet *
-- *********************************
function M.create_project()
    M.create_popup( -- Ouverture d'un popup
        "Créer un nouveau projet",
        "Entrez le chemin du répertoire :",
        "confirm_input",  -- Fonction à appeler pour confirmer
        "close_popup"     -- Fonction à appeler pour fermer
    )
end

return M

