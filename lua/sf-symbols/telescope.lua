local data = require("sf-symbols.data")

local M = {}

local function quote(text)
  return '"' .. text .. '"'
end

local function insert_text(text)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local quoted_text = quote(text)

  local before = line:sub(1, col)
  local after = line:sub(col + 1)

  vim.api.nvim_set_current_line(before .. quoted_text .. after)
  vim.api.nvim_win_set_cursor(0, { row, col + #quoted_text })
end

local function copy_text(text)
  local quoted_text = quote(text)

  vim.fn.setreg("+", quoted_text)
  vim.fn.setreg('"', quoted_text)

  vim.notify("Copied " .. quoted_text, vim.log.levels.INFO)
end

function M.pick(opts)
  opts = opts or {}

  local ok = pcall(require, "telescope")

  if not ok then
    vim.notify("telescope.nvim is not installed", vim.log.levels.ERROR)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local function get_selection()
    local selection = action_state.get_selected_entry()

    if not selection or not selection.value then
      return nil
    end

    return selection.value
  end

  pickers
    .new(opts, {
      prompt_title = "SF Symbols",

      finder = finders.new_table({
        results = data.symbols,

        entry_maker = function(symbol)
          return {
            value = symbol,
            display = symbol,
            ordinal = symbol,
          }
        end,
      }),

      sorter = conf.generic_sorter(opts),

      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local symbol = get_selection()
          actions.close(prompt_bufnr)

          if symbol then
            vim.schedule(function()
              insert_text(symbol)
            end)
          end
        end)

        map("i", "<C-y>", function()
          local symbol = get_selection()
          actions.close(prompt_bufnr)

          if symbol then
            copy_text(symbol)
          end
        end)

        map("n", "<C-y>", function()
          local symbol = get_selection()
          actions.close(prompt_bufnr)

          if symbol then
            copy_text(symbol)
          end
        end)

        return true
      end,
    })
    :find()
end

return M
