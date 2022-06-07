local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local compile_path = install_path .. "/plugin/packer_compiled.lua"

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

return require('packer').startup({
function(use)
  --First of all packer
  use{'wbthomason/packer.nvim'}

  --Load First
  use{'lewis6991/impatient.nvim'}
  use{'nathom/filetype.nvim'}
  use{'nvim-lua/plenary.nvim'}
  use{'kyazdani42/nvim-web-devicons'}
  use{'goolord/alpha-nvim', config = "require('plugins.alpha')"}
  
  -- Colorschemes
  use{'folke/tokyonight.nvim'}

  --General
  use{"kyazdani42/nvim-tree.lua", config = "require('plugins.nvimtree')"}
  use{"folke/which-key.nvim"}
  use{"windwp/nvim-autopairs"}
  use{"akinsho/nvim-toggleterm.lua"}
  use{'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
  use{'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}

  --Telescope
  use{"nvim-telescope/telescope.nvim"}

  --Git
  use{"lewis6991/gitsigns.nvim"}

  if packer_bootstrap then
    require('packer').sync()
  end
end,

config = {
  display = {
    open_fn = function()
      return require('packer.util').float({border = 'single'})
    end
    }
  }
})
