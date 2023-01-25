-- config based on `https://github.com/nvim-lua/kickstart.nvim`

-- `require` is a lua method that loads a given module, in this case,
-- the `package_manager` file in the `lua` directory
local is_bootstraping_package_manager = require("package_manager")
if is_bootstraping_package_manager then
    return
end

-- each string passed to the `require` function loads the respective file in
-- the `lua` directory, consult them in order to better understand the config :D
require("settings")
require("autocmds")
require("keymaps")
require("package_manager_config")
