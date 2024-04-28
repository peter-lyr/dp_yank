local M = {}

local sta, B = pcall(require, 'dp_base')

if not sta then return print('Dp_base is required!', debug.getinfo(1)['source']) end

if B.check_plugins {
      'git@github.com:peter-lyr/dp_init',
      'folke/which-key.nvim',
    } then
  return
end

function M._copy(content)
  vim.fn.setreg('+', content)
  B.notify_info(content)
end

function M._get_full_name()
  return B.rep(B.buf_get_name())
end

function M._get_rela_name()
  return B.rep(vim.fn.bufname())
end

function M.full_name()
  M._copy(M._get_full_name())
end

function M.full_head()
  M._copy(vim.fn.fnamemodify(M._get_full_name(), ':h'))
end

function M.full_tail()
  M._copy(vim.fn.fnamemodify(M._get_full_name(), ':t'))
end

function M.copy_cwd()
  M._copy(vim.loop.cwd())
end

function M.rela_name()
  M._copy(M._get_rela_name())
end

function M.rela_head()
  M._copy(vim.fn.fnamemodify(M._get_rela_name(), ':h'))
end

function M.cur_root()
  local dir = CurRoot[B.get_proj_root()]
  if dir then
    M._copy(dir)
  end
end

require 'which-key'.register {
  ['<leader>y'] = { name = 'dp_copy', },
  ['<leader>yw'] = { function() M.copy_cwd() end, 'copy cwd to clipboard', mode = { 'n', 'v', }, silent = true, },
}

require 'which-key'.register {
  ['<leader>yf'] = { name = 'dp_copy: absolute path', },
  ['<leader>yff'] = { function() M.full_name() end, 'full name', mode = { 'n', 'v', }, silent = true, },
  ['<leader>yft'] = { function() M.full_tail() end, 'full tail', mode = { 'n', 'v', }, silent = true, },
  ['<leader>yfh'] = { function() M.full_head() end, 'full head', mode = { 'n', 'v', }, silent = true, },
}

require 'which-key'.register {
  ['<leader>yr'] = { name = 'dp_copy: relative path', },
  ['<leader>yrr'] = { function() M.rela_name() end, 'rela name', mode = { 'n', 'v', }, silent = true, },
  ['<leader>yrh'] = { function() M.rela_head() end, 'rela head', mode = { 'n', 'v', }, silent = true, },
  ['<leader>yrc'] = { function() M.cur_root() end, 'telescope cur root', mode = { 'n', 'v', }, silent = true, },
}

return M
