local core = require("sf-symbols.core")

local M = {}

function M.pick(opts)
  opts = opts or {}

  local items = vim.tbl_map(function(symbol)
    return {
      text = symbol,
      symbol = symbol,
    }
  end, core.symbols())

  require("snacks").picker.pick({
    title = "SF Symbols",
    items = items,

    format = function(item)
      return {
        { item.symbol },
      }
    end,

    confirm = function(picker, item)
      picker:close()
      core.on_select(item.symbol, "insert")
    end,

    actions = {
      copy = function(picker, item)
        picker:close()
        core.on_select(item.symbol, "copy")
      end,
    },

    win = {
      input = {
        keys = {
          ["<C-y>"] = { "copy", mode = { "i", "n" } },
        },
      },
    },
  })
end

return M
