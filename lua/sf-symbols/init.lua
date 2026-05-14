local M = {}

function M.setup()
  vim.api.nvim_create_user_command("SFSymbols", function()
    require("sf-symbols.telescope").pick()
  end, {})
end

function M.pick()
  require("sf-symbols.telescope").pick()
end

return M
