local function move_zero(t)
  local ret,count = {},0
  for i=1,#t do
    if t[i] ~= 0 then ret[#ret+1] = t[i]
    else count = count + 1 end
  end
  for i=1,count do
    ret[#ret+1] = 0
  end
  return ret
end

print(table.concat(move_zero({1,0,3,0,0,5}),' '))
print(table.concat(move_zero({1,6,4}),' '))
print(table.concat(move_zero({0,1,0,2,0}),' '))

