#!/usr/bin/env lua

local function uniq(t)
  assert(type(t) == "table", "t must be a table!")
  local hash,ret = {},{}
  for i=1,#t do hash[t[i]] = (hash[t[i]] or 0) + 1 end
  for k,v in pairs(hash) do if v == 1 then ret[#ret+1] = k end end
  return ret
end

local function two_out_of_three(t)
  assert(type(t) == "table", "t must be a table!")
  local hash,ret = {},{}
  for i=1,#t do
    local u = uniq(t[i])
    for j=1,#u do hash[u[j]] = (hash[u[j]] or 0) + 1 end
  end
  for k,v in pairs(hash) do if v >= 2 then ret[#ret+1] = k end end
  table.sort(ret)
  return ret
end

print(table.unpack(two_out_of_three{{1,1,2,4},{2,4},{4}}))
print(table.unpack(two_out_of_three{{4,1},{2,4},{1,2}}))

