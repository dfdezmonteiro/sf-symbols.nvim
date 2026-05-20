local core = require("sf-symbols.core")

local M = {}

function M.pick(opts)
  opts = opts or {}

  local Snacks = require("snacks")

  local items = vim.tbl_map(function(symbol)
    return {
      text = symbol,
    }
  end, core.symbols())

  Snacks.picker.pick({
    source = "sf-symbols",
    title = "SF Symbols",
    items = items,

    format = function(item)
      return {
        { item.text },
      }
    end,

    confirm = function(picker, item)
      picker:close()
      core.on_select(item.text, "insert")
    end,

    actions = {
      copy = function(picker, item)
        picker:close()
        core.on_select(item.text, "copy")
      end,
    },

    win = {
      input = {
        keys = {
          ["<C-y>"] = { "copy", mode = { "i", "n" } },
        },
      },

      list = {
        keys = {
          ["<C-y>"] = "copy",
        },
      },

      preview = {
        enabled = false,
      },
    },
  })
end

return M
