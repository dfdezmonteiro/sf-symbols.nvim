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

    preview = function()
      return false
    end,

    layout = {
      preset = "select",
      hidden = { "preview" },
    },

    format = "text",

    confirm = function(picker, item)
      picker:close()

      if item then
        core.on_select(item.text, "insert")
      end
    end,

    actions = {
      copy = function(picker, item)
        picker:close()

        if item then
          core.on_select(item.text, "copy")
        end
      end,
    },

    win = {
      input = {
        keys = {
          ["<C-y>"] = { "copy", mode = { "i", "n" } },

          -- Desactivamos toggle preview.
          ["<M-p>"] = false,
        },
      },

      list = {
        keys = {
          ["<C-y>"] = "copy",

          -- Desactivamos toggle preview.
          ["<M-p>"] = false,
        },
      },
    },
  })
end

return M
