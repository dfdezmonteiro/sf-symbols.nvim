local core = require("sf-symbols.core")

local M = {}

function M.pick(opts)
  opts = opts or {}

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers
    .new(opts, {
      prompt_title = "SF Symbols",

      finder = finders.new_table({
        results = core.symbols(),
      }),

      sorter = conf.generic_sorter(opts),

      attach_mappings = function(prompt_bufnr, map)
        local function selected_symbol()
          local selection = action_state.get_selected_entry()
          if not selection then
            return nil
          end

          return selection.value or selection[1]
        end

        actions.select_default:replace(function()
          local symbol = selected_symbol()
          actions.close(prompt_bufnr)
          core.on_select(symbol, "insert")
        end)

        local function copy_symbol()
          local symbol = selected_symbol()
          actions.close(prompt_bufnr)
          core.on_select(symbol, "copy")
        end

        map("i", "<C-y>", copy_symbol)
        map("n", "<C-y>", copy_symbol)

        return true
      end,
    })
    :find()
end

return M
