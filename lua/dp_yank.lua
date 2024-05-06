local M = {}

local sta, B = pcall(require, 'dp_base')

if not sta then return print('Dp_base is required!', debug.getinfo(1)['source']) end

if B.check_plugins {
      'git@github.com:peter-lyr/dp_init',
      'folke/which-key.nvim',
    } then
  return
end

function M._yank(content)
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
  M._yank(M._get_full_name())
end

function M.full_head()
  M._yank(vim.fn.fnamemodify(M._get_full_name(), ':h'))
end

function M.full_tail()
  M._yank(vim.fn.fnamemodify(M._get_full_name(), ':t'))
end

function M.yank_cwd()
  M._yank(vim.loop.cwd())
end

function M.rela_name()
  M._yank(M._get_rela_name())
end

function M.rela_head()
  M._yank(vim.fn.fnamemodify(M._get_rela_name(), ':h'))
end

function M.cur_root()
  local dir = CurRoot[B.get_proj_root()]
  if dir then
    M._yank(dir)
  end
end

require 'which-key'.register {
  ['<leader>yk'] = { name = 'yank', },
  ['<leader>ykw'] = { function() M.yank_cwd() end, 'yank cwd to clipboard', mode = { 'n', 'v', }, silent = true, },
}

require 'which-key'.register {
  ['<leader>ykf'] = { name = 'yank.absolute', },
  ['<leader>ykff'] = { function() M.full_name() end, 'yank full name to clipboard', mode = { 'n', 'v', }, silent = true, },
  ['<leader>ykft'] = { function() M.full_tail() end, 'yank full tail to clipboard', mode = { 'n', 'v', }, silent = true, },
  ['<leader>ykfh'] = { function() M.full_head() end, 'yank full head to clipboard', mode = { 'n', 'v', }, silent = true, },
}

require 'which-key'.register {
  ['<leader>ykr'] = { name = 'yank.relative', },
  ['<leader>ykrr'] = { function() M.rela_name() end, 'yank rela name to clipboard', mode = { 'n', 'v', }, silent = true, },
  ['<leader>ykrh'] = { function() M.rela_head() end, 'yank rela head to clipboard', mode = { 'n', 'v', }, silent = true, },
  ['<leader>ykrc'] = { function() M.cur_root() end, 'yank CurRoot to clipboard', mode = { 'n', 'v', }, silent = true, },
}

return M
