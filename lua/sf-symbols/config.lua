local M = {}

M.defaults = {
  picker = "auto", -- "auto" | "telescope" | "fzf_lua" | "snacks" | "vim_ui_select"
  insert_quotes = true,
}

M.options = vim.deepcopy(M.defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
