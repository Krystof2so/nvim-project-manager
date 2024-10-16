# manage-project

A simple project manager plugin for Neovim, allowing you to create and open projects easily using `telescope` and `nvim-tree`.

(Under construction)

---

# manage-project FR 

Un simple plugin de gestion de projet pour Neovim, vous permettant de créer et d'ouvrir des projets facilement en utilisant `telescope` et `nvim-tree`.

(En construction)

---

## Installation

To install this plugin using [lazy.nvim](https://github.com/folke/lazy.nvim), add the following to your plugin setup:

```lua
{
  'tonnomgithub/project-manager.nvim',
  requires = {
    'nvim-tree/nvim-tree.lua',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    -- Optionally configure the plugin if necessary
  end
}
```

## Configuration

In `lua/config/project_manager.lua` :
```lua
-- ~/.config/nvim/lua/config/project_manager.lua

-- Tenter de charger le module project_manager
local ok, project_manager = pcall(require, 'project_manager')
if not ok then
    vim.notify('Erreur lors du chargement de project_manager: ' .. project_manager, vim.log.levels.ERROR)
    return
end

-- Commandes personnalisées
vim.api.nvim_create_user_command('CreateProject', function()
    project_manager.create_project()
end, { nargs = 0 })

vim.api.nvim_create_user_command('OpenProject', function()
    project_manager.open_project()
end, { nargs = 0 })

-- Options pour les keymaps
vim.api.nvim_set_keymap('n', '<leader>cp', ':CreateProject<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>op', ':OpenProject<CR>', { noremap = true, silent = true })
```

## Commands 

- `:CreateProject` - Create a new project
- `:OpenProject` - Open an existing project using Telescope

## Keymaps

- `<leader>cp` : Create project - Crée un projet.
- `<leader>op` : Open project - Ouvre un projet.

---

## A implémenter :
- Enregistrement projet dans un fichier dédié, et ouverture d'un projet depuis cette liste (via **telescope**)

