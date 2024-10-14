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

## Commands

- `:CreateProject` - Create a new project
- `:OpenProject` - Open an existing project using Telescope
