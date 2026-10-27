#!usr/local/env lua

local function reflect(u)
  assert(type(u) == 'number','u must be a number!')
  local r = 0
  while u > 0 do
    r = (r << 1) | (u & 1)
    u = u >> 1
  end
  return r
end

local function binary_reflection(t)
  assert(type(t) == 'table','t must be a table!')
  local ps = {}
  for i,v in ipairs(t) do
    ps[i] = {reflect(v),v}
  end

  table.sort(ps,function(a,b)
	       if a[1] ~= b[1] then return a[1] < b[1] end
	       return a[2] < b[2]
  end)
  
  local out = {}
  for i,p in ipairs(ps) do out[i] = p[2] end
  return out
end

print(table.unpack(binary_reflection({3,6,12})))
print(table.unpack(binary_reflection({1,2,4,8})))
print(table.unpack(binary_reflection({7,8,9,10})))
print(table.unpack(binary_reflection({5,9,15,17})))
print(table.unpack(binary_reflection({11,13,14,19})))

