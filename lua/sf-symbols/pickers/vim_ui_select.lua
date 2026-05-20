local core = require("sf-symbols.core")

local M = {}

function M.pick(opts)
  opts = opts or {}

  vim.ui.select(core.symbols(), {
    prompt = "SF Symbols",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    core.on_select(choice, "insert")
  end)
end

return M
