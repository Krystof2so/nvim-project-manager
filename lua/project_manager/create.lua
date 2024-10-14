-- Logique de création du projet

local M = {}

local project_path = vim.fn.expand("~") .. "/Documents/DEVELOPPEMENT/PROJETS/"  -- Variable à modifier selon son propre système de fichiers

-- Fonction pour créer un nouveau projet :
function M.create_project()
  vim.ui.input({ prompt = 'Nom du projet à créer: ' }, function(input)
    if input ~= nil then  -- PREVOIR SI SAISIE DE CARACTERES SPECIAUX
      local new_project_dir = project_path .. input
      os.execute("mkdir -p " .. new_project_dir)
      print("Projet créé : " .. new_project_dir)
      -- Optionnel : ouvre automatiquement nvim-tree dans le projet
      vim.cmd('cd ' .. new_project_dir)
      vim.cmd('NvimTreeOpen')
    end
  end)
end

return M

