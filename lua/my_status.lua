local M = {}

function M.gitsigns_added_removed()
  local gs_dict = vim.b.gitsigns_status_dict
  if not gs_dict then
    return ""
  end
  local added = gs_dict.added or 0
  local removed = gs_dict.removed or 0

  -- Only show if there's something to report
  if added == 0 and removed == 0 then
    return ""
  end

  -- e.g., +1 -1
  return string.format("%d %d", added, removed)
end



M.last_key = ""

-- Note: vim.on_key is available in Neovim 0.9+
vim.on_key(function(key)
  M.last_key = key
end)

function M.get_last_command()
  return M.last_key ~= "" and M.last_key or "None"
end


--vim.api.nvim_create_autocmd("CmdlineLeave", {
  --callback = function()
    --M.last_cmd = vim.fn.getcmdline()
  --end,
--})
--
--function M.get_last_command()
  --return M.last_cmd ~= "" and M.last_cmd or "No Cmd"
--end

--function M.last_keystroke()
  ---- Show something like "Keys: o" if the last key was 'o'
  --if vim.g.last_key and vim.g.last_key ~= "" then
    --return vim.g.last_key
  --else
    --return "bla"
  --end
--end

return M
