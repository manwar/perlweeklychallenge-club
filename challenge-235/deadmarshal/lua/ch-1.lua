#!/usr/bin/env lua

local function is_ascending(t)
  assert(type(t) == 'table','t must be a table!')
  local c = 1
  for i=1,#t-1 do
    if t[i] < t[i+1] then c = c + 1 end
  end
  return c == #t
end

local function remove_one(t)
  assert(type(t) == 'table','t must be a table!')
  local res = false
  for i=1,#t do
    local ret = {table.unpack(table.move(t,1,i-1,1,{})),
		 table.unpack(table.move(t,i+1,#t,1,{}))}
    if i == 1 then ret = table.move(t,2,#t,1,{})
    elseif i == #t then ret = table.move(t,1,#t-1,1,{})
    end
    if is_ascending(ret) then res = true end
  end
  return res
end

print(remove_one{0,2,9,4,5})
print(remove_one{5,1,3,2})
print(remove_one{2,2,3})

