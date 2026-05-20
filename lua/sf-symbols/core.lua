local data = require("sf-symbols.data")
local config = require("sf-symbols.config")

local M = {}

function M.symbols()
  return data.symbols or {}
end

function M.format(symbol)
  if config.options.insert_quotes then
    return '"' .. symbol .. '"'
  end

  return symbol
end

function M.insert(symbol)
  local text = M.format(symbol)
  vim.api.nvim_put({ text }, "c", true, true)
end

function M.copy(symbol)
  local text = M.format(symbol)
  vim.fn.setreg("+", text)
  vim.notify("Copied " .. text, vim.log.levels.INFO)
end

function M.on_select(symbol, action)
  if not symbol or symbol == "" then
    return
  end

  if action == "copy" then
    M.copy(symbol)
  else
    M.insert(symbol)
  end
end

return M
