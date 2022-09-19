local function trim_list(t, i)
  assert(type(t) == 'table', 't must be a table!')
  local filtered = {}
  for j=1, #t do
    if(t[j] > i) then table.insert(filtered, t[j]) end
  end
  return filtered
end

local n,i = {1,4,2,3,5}, 3
local n2,i2 = {9,0,6,2,3,8,5}, 4
print(table.unpack(trim_list(n,i)))
print(table.unpack(trim_list(n2,i2)))
