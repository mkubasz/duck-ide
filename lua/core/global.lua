local global = {}
local vim = vim
local home = os.getenv("HOME")
local path_sep = "/"
local os_name = vim.loop.os_uname().sysname

function global:load_variables()
  self.is_mac = os_name == "Darwin"
  self.is_linux = os_name == "Linux"

  self.vim_path = vim.fn.stdpath("config")
  self.cache_dir = home .. path_sep .. ".cache" .. path_sep .. "nvim" .. path_sep
  self.modules_dir = self.vim_path .. path_sep .. "lua" .. path_sep .. "packer_compiled.lua"
  self.path_sep = path_sep
  self.home = home
  self.data_dir = string.format("%s%ssite%s", vim.fn.stdpath("data"), path_sep, path_sep)
  self.cache_dir = vim.fn.stdpath("cache")
  self.log_dir = string.format("%s", self.cache_dir)
  self.log_path = string.format("%s%s%s", self.log_dir, path_sep, "nvim_debug.log")
end

global:load_variables()

return global
