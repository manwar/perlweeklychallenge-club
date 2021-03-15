#!/usr/bin/env lua

require'util'

local t1 = {}
t1.DEFAULT_INPUT = {"opt", "bat", "saw", "tab", "pot", "top", "was"}

function t1.keygen(s)
  local tbl = {}
  s:gsub('.', function(c) table.insert(tbl, c) end)
  table.sort(tbl)
  return table.concat(tbl)
end

function t1.group_anagrams(coll)
  local groups = util.group_by(t1.keygen, coll)

  -- sorting for stable results (for testing)
  table.sort(groups)

  return groups
end

function t1.run(args)
  local s
  if #args > 0 then
    s = args
  else
    s = t1.DEFAULT_INPUT
  end
  local groups = t1.group_anagrams(s)

  local lead = ''
  io.write('[ ')
  for _, v in pairs(groups) do
    table.sort(v)
    io.write(lead .. '("')
    io.write(table.concat(v, '", "'))
    io.write('")')
    lead = '  '
  end
  print(' ]')
end

return t1
