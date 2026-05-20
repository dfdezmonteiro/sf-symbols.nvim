local core = require("sf-symbols.core")

local M = {}

function M.pick(opts)
  opts = opts or {}

  require("fzf-lua").fzf_exec(core.symbols(), {
    prompt = "SF Symbols> ",

    actions = {
      ["default"] = function(selected)
        core.on_select(selected and selected[1], "insert")
      end,

      ["ctrl-y"] = function(selected)
        core.on_select(selected and selected[1], "copy")
      end,
    },
  })
end

return M
