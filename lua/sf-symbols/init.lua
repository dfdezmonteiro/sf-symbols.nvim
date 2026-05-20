local config = require("sf-symbols.config")

local M = {}

function M.setup(opts)
  config.setup(opts)

  vim.api.nvim_create_user_command("SFSymbols", function(command_opts)
    M.pick({
      picker = command_opts.args ~= "" and command_opts.args or nil,
    })
  end, {
    nargs = "?",
    complete = function()
      return {
        "auto",
        "telescope",
        "fzf_lua",
        "snacks",
        "vim_ui_select",
      }
    end,
  })
end

local function has(module)
  local ok = pcall(require, module)
  return ok
end

local function resolve_picker(name)
  if name and name ~= "auto" then
    return name
  end

  if has("snacks") then
    return "snacks"
  end

  if has("fzf-lua") then
    return "fzf_lua"
  end

  if has("telescope") then
    return "telescope"
  end

  return "vim_ui_select"
end

function M.pick(opts)
  opts = opts or {}

  local picker_name = resolve_picker(opts.picker or config.options.picker)
  local ok, picker = pcall(require, "sf-symbols.pickers." .. picker_name)

  if not ok then
    vim.notify("sf-symbols.nvim: picker not available: " .. picker_name, vim.log.levels.ERROR)
    return
  end

  picker.pick(opts)
end

return M
