local function frequency_equalizer(str)
  local t,vals = {},{}
  setmetatable(t,{__index = function(t,k) return 0 end})
  for i=1, #str do
    local c = str:sub(i,i)
    t[c] = t[c] + 1
  end
  for k,v in pairs(t) do vals[#vals+1] = v end
  table.sort(vals,function(a,b) return a > b end)
  if vals[1] == vals[2]+1 and vals[#vals] == vals[2] then
    return true
  end
  return false
end

print(frequency_equalizer('abbc'))
print(frequency_equalizer('xyzyyxz'))
print(frequency_equalizer('xzxz'))
      
