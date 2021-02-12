#!/usr/bin/env lua

local t1 = {}
t1.DEFAULT_INPUT = {'abcde', 'a*e'}

--[[
--  Lua does not have a built-in globbing function, but there are 3rd party
--  libraries. Instead we will simply stick to the task's description of the
--  two wild characters and no escape mechanism. We can accomplish that pretty
--  easily with Lua's patterns, which have a small number of special characters
--  to escape and straight-forward translations of the wild characters.
--]]
function t1.pattern_match(s, p)
  local specials = '^[%^%$%(%)%%%.%[%]%+%-]$'

  local pats = {'^'}
  for c in p:gmatch('.') do
    if c == '?' then
      table.insert(pats, '.')
    elseif c == '*' then
      table.insert(pats, '.+')
    elseif c:match(specials) then
      table.insert(pats, '%' .. c)
    else
      table.insert(pats, c)
    end
  end
  table.insert(pats, '$')

  local luapat = table.concat(pats)
  return s:match(luapat)
end

function t1.run(args)
  local s, p
  if #args > 0 then
    s, p = args[1], args[2]
  else
    s, p = table.unpack(t1.DEFAULT_INPUT)
  end

  if t1.pattern_match(s, p) then
    print(1)
  else
    print(0)
  end
end

return t1
